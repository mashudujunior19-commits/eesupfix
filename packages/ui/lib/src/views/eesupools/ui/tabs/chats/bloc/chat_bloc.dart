import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:data/eesupools/models/chat_message.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_level.dart';
import 'package:data/eesupools/models/media_file.dart';
import 'package:data/eesupools/repository/eesupool_chats_repo.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:meta/meta.dart';
import 'package:ui/src/views/eesupools/ui/tabs/chats/bloc/chat_crypto.dart';

part 'chat_event.dart';
part 'chat_state.dart';

enum PendingStatus { sending, failed, sent }

typedef SentChat = ({int id, bool isApproved, String moderationStatus});

/// A message the user sent that is not (yet) in the server's list.
class PendingChatMessage {
  PendingChatMessage({
    required this.localId,
    required this.message,
    required this.pool,
    required this.text,
    required this.files,
    required this.replyTo,
    required this.broadcastTo,
    this.status = PendingStatus.sending,
    this.error,
    this.serverId,
  });

  final String localId;

  /// What the chat list renders while the message is pending (negative id).
  final ChatMessage message;
  final EESUpool pool;
  final String text;
  final List<File> files;
  final ChatMessage? replyTo;
  final List<EESUpoolLevel>? broadcastTo;
  PendingStatus status;
  String? error;

  /// Set once the server accepted the message; the pending entry is dropped
  /// as soon as the server's list contains it.
  int? serverId;
}

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final EESUpoolRepository _poolRepo;

  List<ChatMessage> _serverChats = const [];
  final List<PendingChatMessage> _pending = [];
  Timer? _poller;

  ChatBloc(this._poolRepo) : super(ChatInitial()) {
    on<ChatStreamStarted>((event, emit) async {
      final stream = _poolRepo.fetchEESUpoolsChatMessages(
        event.eesupoolId,
        200,
      );
      // Safety net next to realtime: poll so messages from other members still
      // arrive if a realtime event is missed.
      _poller?.cancel();
      _poller = Timer.periodic(const Duration(seconds: 15), (_) {
        if (!isClosed) add(ChatRefreshRequested(event.eesupoolId));
      });
      await emit.forEach(
        stream,
        onData: ((message) {
          return message.fold(
            (l) => ChatsError(l),
            (r) {
              _setServerChats(r);
              return _loaded();
            },
          );
        }),
      );
    });

    on<ChatRefreshRequested>((event, emit) async {
      await _refresh(event.poolId, emit);
    });

    on<MessageSeenUpdated>((event, emit) {
      _poolRepo.addMessageSeens(event.messageId, event.memberId);
    });

    on<MessageReactionAdded>((event, emit) async {
      final result = await _poolRepo.addMessageReaction(
        event.authorId,
        event.messageId,
        event.liked,
      );
      if (result.isRight) await _refresh(event.poolId, emit);
    });

    on<MessageDeleted>((event, emit) async {
      final result = await _poolRepo.softDeleteChatMessage(event.messageId);
      if (result.isRight) await _refresh(event.poolId, emit);
    });

    on<MessageFlagged>((event, emit) async {
      final result = await _poolRepo.flagMessage(event.messageId);
      if (result.isRight) await _refresh(event.poolId, emit);
    });

    on<ChatMessageSendRequested>((event, emit) async {
      final pending = _newPending(event);
      _pending.add(pending);
      emit(_loaded());
      await _deliver(pending, emit);
    });

    on<ChatMessageRetried>((event, emit) async {
      final index = _pending.indexWhere((p) => p.localId == event.localId);
      if (index == -1) return;
      final pending = _pending[index];
      pending.status = PendingStatus.sending;
      pending.error = null;
      emit(_loaded());
      await _deliver(pending, emit);
    });

    on<ChatPendingDismissed>((event, emit) {
      _pending.removeWhere((p) => p.localId == event.localId);
      emit(_loaded());
    });
  }

  @override
  Future<void> close() {
    _poller?.cancel();
    return super.close();
  }

  ChatMessagesLoaded _loaded({String? notice}) => ChatMessagesLoaded(
        _serverChats,
        pending: List.unmodifiable(_pending),
        notice: notice,
      );

  void _setServerChats(List<ChatMessage> chats) {
    _serverChats = chats;
    final ids = chats.map((c) => c.id).toSet();
    _pending.removeWhere((p) => p.serverId != null && ids.contains(p.serverId));
  }

  Future<void> _refresh(int poolId, Emitter<ChatState> emit) async {
    final result = await _poolRepo.getChatMessages(poolId, 200);
    result.fold((_) {}, (r) {
      _setServerChats(r);
      emit(_loaded());
    });
  }

  PendingChatMessage _newPending(ChatMessageSendRequested event) {
    final now = DateTime.now();
    return PendingChatMessage(
      localId: 'local_${now.microsecondsSinceEpoch}',
      pool: event.pool,
      text: event.text,
      files: event.files,
      replyTo: event.replyTo,
      broadcastTo: event.broadcastTo,
      message: ChatMessage(
        // Negative: never collides with a server id.
        id: -(now.microsecondsSinceEpoch ~/ 1000),
        eesupoolId: event.pool.eesupoolId!,
        authorId: event.pool.memberId!,
        authorName: 'You',
        createdAt: now,
        content: _tryEncrypt(event.text),
        reply: event.replyTo,
        localFiles: event.files,
        isApproved: true,
        isDeleted: false,
      ),
    );
  }

  /// Encrypts for display of the optimistic message; null when the chat key is
  /// missing (the send itself then fails with a visible error).
  String? _tryEncrypt(String text) {
    if (text.isEmpty) return null;
    try {
      return encryptChatText(text);
    } catch (_) {
      return null;
    }
  }

  Future<void> _deliver(
    PendingChatMessage pending,
    Emitter<ChatState> emit,
  ) async {
    final result = await _send(pending);

    if (result.isLeft) {
      pending.status = PendingStatus.failed;
      pending.error = result.left.message;
      emit(_loaded());
      return;
    }

    final sent = result.right;
    pending.status = PendingStatus.sent;
    pending.serverId = sent.id;
    emit(_loaded(
      notice: sent.moderationStatus == 'held'
          ? 'Your message is pending review. An admin will check it before '
              'it is delivered.'
          : null,
    ));
    // Show the server's copy now instead of waiting for the realtime event.
    await _refresh(pending.pool.eesupoolId!, emit);
  }

  Future<Either<EESUpException, SentChat>> _send(PendingChatMessage p) async {
    try {
      return await _sendUnsafe(p);
    } catch (e) {
      // e.g. the chat encryption key is not configured: show "Not sent".
      return Left(EESUpException(message: 'Could not send the message: $e'));
    }
  }

  Future<Either<EESUpException, SentChat>> _sendUnsafe(
      PendingChatMessage p) async {
    final media = <MediaFile>[];
    // Uploads run in parallel; any failure aborts the send so it can be retried.
    final uploads = await Future.wait(p.files.map(_poolRepo.uploadFile));
    for (var i = 0; i < uploads.length; i++) {
      final upload = uploads[i];
      if (upload.isLeft) return Left(upload.left);
      final url = upload.right;
      if (url != null) {
        final path = p.files[i].path;
        media.add(MediaFile(
          url: encryptChatText(url),
          type: path.split('.').last,
          name: path.split(RegExp(r'[\\/]')).last,
        ));
      }
    }

    final tags = <String>[
      for (final tag in p.pool.chatTags ?? <String>[])
        if (p.text.contains(tag)) tag,
    ];
    for (final tag in p.replyTo?.hashTags ?? <String>[]) {
      if (!tags.contains(tag)) tags.add(tag);
    }

    return _poolRepo.sendChatMessage(
      poolId: p.pool.eesupoolId!,
      authorId: p.pool.memberId!,
      content: p.text.isEmpty ? null : encryptChatText(p.text),
      plainText: p.text,
      replyOnId: p.replyTo?.id,
      media: media,
      hashTags: tags,
      broadcastTo: p.broadcastTo,
      isApproved: p.pool.isCensored == true ? false : true,
    );
  }
}
