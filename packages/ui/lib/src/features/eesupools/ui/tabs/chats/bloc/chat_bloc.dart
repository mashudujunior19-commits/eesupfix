import 'package:bloc/bloc.dart';
import 'package:data/eesupools/models/chat_message.dart';
import 'package:data/eesupools/repository/eesupool_chats_repo.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:meta/meta.dart';
import 'package:data/utils/eesup_exception.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final EESUpoolRepository _poolRepo;

  ChatBloc(this._poolRepo) : super(ChatInitial()) {
    on<ChatStreamStarted>((event, emit) async {
      final stream = _poolRepo.fetchEESUpoolsChatMessages(
        event.eesupoolId,
        200,
      );
      await emit.forEach(
        stream,
        onData: ((message) {
          return message.fold(
            (l) => ChatsError(l),
            (r) => ChatMessagesLoaded(r),
          );
        }),
      );
    });

    on<MessageSeenUpdated>((event, emit) {
      _poolRepo.addMessageSeens(event.messageId, event.memberId);
    });

    on<MessageReactionAdded>((event, emit) {
      _poolRepo.addMessageReaction(
          event.authorId, event.messageId, event.liked);

      if (state is ChatMessagesLoaded) {
       // List<ChatMessage> messages = [...(state as ChatMessagesLoaded).chats];
      }
    });
  }
}
