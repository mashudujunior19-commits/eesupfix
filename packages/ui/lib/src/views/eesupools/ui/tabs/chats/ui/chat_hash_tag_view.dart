import 'package:data/eesupools/models/chat_message.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/repository/eesupool_chats_repo.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/views/eesupools/ui/tabs/chats/ui/widgets/message_bubble.dart';

class ChatHashTagView extends StatefulWidget {
  const ChatHashTagView({super.key, required this.pool, required this.tag});
  final EESUpool pool;
  final String tag;

  @override
  State<ChatHashTagView> createState() => _ChatHashTagViewState();
}

class _ChatHashTagViewState extends State<ChatHashTagView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(
          widget.tag,
          style: const TextStyle(color: Colors.blue),
        ),
      ),
      body: FutureBuilder<Either<EESUpException, List<ChatMessage>>>(
        future: context
            .read<EESUpoolRepository>()
            .getChatMessagesByHashTag(widget.pool.eesupoolId!, widget.tag, 100),
        builder: (context, snap) {
          print(snap.data?.right);
          if (snap.data != null) {
            List<ChatMessage> messages = [];
            final res = snap.data!;
            res.fold((r) {}, (l) {
              messages = [...l];
            });
            return ListView(
              reverse: true,
              children: [
                const SizedBox(height: 50),
                for (int index = 0; index < messages.length; index++)
                  MessageBubble(message: messages[index], pool: widget.pool),
                const SizedBox(height: 100),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
