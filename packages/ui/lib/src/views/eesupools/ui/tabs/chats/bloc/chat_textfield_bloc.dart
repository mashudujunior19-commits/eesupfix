import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:data/eesupools/repository/eesupool_chats_repo.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:either_dart/either.dart';
import 'package:data/eesupools/models/chat_message.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_level.dart';
import 'package:data/eesupools/models/media_file.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:data/utils/eesup_exception.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'chat_textfield_event.dart';
part 'chat_textfield_state.dart';

class ChatTextFieldBloc extends Bloc<ChatTextFieldEvent, ChatTextFieldState> {
  final EESUpoolRepository _eeupoolsRepo;

  ChatTextFieldBloc(this._eeupoolsRepo)
      : super(
          ChatTextFieldCurrentState(const <File>[], null),
        ) {
    on<ChatAttachmentsPicked>((event, emit) {
      if (state is ChatTextFieldCurrentState) {
        final current = (state as ChatTextFieldCurrentState);
        List<File> currentFiles = [...current.files];
        currentFiles.addAll(event.files);
        final replyTo = current.replyTo;
        emit(ChatTextFieldCurrentState(currentFiles, replyTo));
      }
    });

    on<ChatMessageReplyToAdded>((event, emit) {
      if (state is ChatTextFieldCurrentState) {
        final current = (state as ChatTextFieldCurrentState);
        final files = current.files;
        emit(ChatTextFieldCurrentState(files, event.message));
      }
    });

    on<ChatMessageReplyToRemoved>((event, emit) {
      if (state is ChatTextFieldCurrentState) {
        final current = (state as ChatTextFieldCurrentState);
        final files = current.files;
        emit(ChatTextFieldCurrentState(files, null));
      }
    });

    on<ChatBoxReset>((event, emit) {
      emit(ChatTextFieldCurrentState(const [], null));
    });

    on<ChatMessageSent>((event, emit) async {
      final message = (state as ChatTextFieldCurrentState);

      emit(ChatLoading());
      final results = await _sendMessage(
        event.pool.memberId!,
        event.pool.eesupoolId!,
        event.text,
        event.pool.chatTags ?? [],
        event.pool.isCensored == true ? false : true,
        event.broadcastTo ?? [],
        message.files,
        message.replyTo,
      );

      results.fold((l) {
        emit(ChatTextFieldError(l));
      }, (r) {
        emit(MessageSentSuccess());
      });
    });
  }

  Future<Either<EESUpException, bool>> _sendMessage(
    String memberId,
    int poolId,
    String message,
    List<String> tags,
    bool isApproved,
    List<EESUpoolLevel>? broadcastTo,
    List<File> files,
    ChatMessage? replyTo,
  ) async {
    final List<MediaFile> mediaFiles = [];

    for (final file in files) {
      final result = await _eeupoolsRepo.uploadFile(file);
      result.fold((ex) {
        return Left(ex);
      }, (url) {
        if (url != null) {
          mediaFiles.add(
            MediaFile(
              url: _encrypt(url),
              type: file.path.split('.').last,
              name: file.path.split('/').last,
            ),
          );
        }
      });
    }

    final inharitedTags = replyTo?.hashTags ?? [];
    final newTags = [..._findTagsInMessage(tags, message)];
    for (final tag in inharitedTags) {
      if (!newTags.contains(tag)) {
        newTags.add(tag);
      }
    }

    print(newTags);

    final result = await _eeupoolsRepo.sendChatMessage(
      ChatMessage(
        id: 1,
        eesupoolId: poolId,
        authorId: memberId,
        replyOnId: replyTo?.id,
        createdAt: DateTime.now(),
        content: message.isEmpty ? null : _encrypt(message),
        media: mediaFiles,
        isApproved: isApproved,
        hashTags: newTags,
        isDeleted: false,
        broadcastTo: broadcastTo,
      ),
    );

    return result;
  }

  String _encrypt(String str) {
    // Generate a key
    final key = encrypt.Key.fromBase16(dotenv.get('CHAT_SECRET'));
    final iv = encrypt.IV.fromBase16(dotenv.get('CHAT_SECRET'));
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    // Encrypt the plain text
    final encrypted = encrypter.encrypt(str, iv: iv);
    return encrypted.base16;
  }

  List<String> _findTagsInMessage(List<String> tags, String message) {
    print(tags);
    List<String> foundTags = [];

    for (String tag in tags) {
      if (message.contains(tag)) {
        foundTags.add(tag);
      }
    }

    return foundTags;
  }
}
