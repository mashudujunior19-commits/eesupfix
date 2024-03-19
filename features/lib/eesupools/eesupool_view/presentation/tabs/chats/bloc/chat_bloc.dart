import 'package:bloc/bloc.dart';
import 'package:data_sources/eesupools/models/chat_message.dart';
import 'package:meta/meta.dart';
import 'package:repository/eesupools/eesupool_chats_repo.dart';
import 'package:repository/eesupools/eesupool_repo.dart';
import 'package:repository/utils/eesup_exception.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final EESUpoolRepository _poolRepo;

  ChatBloc(this._poolRepo) : super(ChatInitial()) {
    on<ChatStreamStarted>((event, emit) async {
      await emit.forEach(
        _poolRepo.fetchEESUpoolsChatMessages(event.eesupoolId, 200),
        onData: ((message) {
          return message.fold(
            (l) => ChatsError(l),
            (r) => ChatMessagesLoaded(r),
          );
        }),
      );
    });
  }
}
