import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:ui/core/extensions/sizedbox_ext.dart';
import 'package:ui/eesupools/ui/tabs/chats/bloc/chat_bloc.dart';
import 'package:ui/eesupools/ui/tabs/chats/ui/chat_text_field/bloc/chat_textfield_bloc.dart';
import 'package:ui/eesupools/ui/tabs/chats/ui/chat_text_field/chat_textfield.dart';
import 'package:ui/eesupools/ui/tabs/chats/ui/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ChatsTab extends StatelessWidget {
  const ChatsTab({super.key, required this.pool});
  final EESUpool pool;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChatBloc(context.read<EESUpoolRepository>())
            ..add(ChatStreamStarted(pool.eesupoolId!)),
        ),
        BlocProvider(
          create: (context) => ChatTextFieldBloc(
            context.read<EESUpoolRepository>(),
          ),
        ),
      ],
      child: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const _Encryption(),
                  () {
                    if (state is ChatMessagesLoaded) {
                      final chats = state.chats;

                      return Expanded(
                        child: ListView.builder(
                          reverse: true,
                          itemCount: chats.length,
                          padding: const EdgeInsets.only(
                              bottom: 40, left: 15, right: 15),
                          itemBuilder: (context, index) {
                            final chat = chats[index];
                            return MessageBubble(message: chat, pool: pool);
                          },
                        ),
                      );
                    } else {
                      return 0.sW;
                    }
                  }(),
                ],
              ),
            ),
            bottomNavigationBar: ChatTextField(pool: pool),
          );
        },
      ),
    );
  }
}

class _Encryption extends StatelessWidget {
  const _Encryption();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          IconlyLight.lock,
          color: Colors.grey.shade400,
          size: 13,
        ),
        const SizedBox(width: 5),
        Text(
          'End-to-End encryption',
          style: context.textTheme.labelSmall?.copyWith(
            color: Colors.grey.shade400,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
