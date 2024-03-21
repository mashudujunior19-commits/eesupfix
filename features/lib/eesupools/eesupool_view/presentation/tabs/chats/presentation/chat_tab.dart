import 'package:data_sources/eesupools/models/eesupool.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/eesupools/eesupool_view/presentation/tabs/chats/bloc/chat_bloc.dart';
import 'package:features/eesupools/eesupool_view/presentation/tabs/chats/presentation/widgets/chat_message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:repository/eesupools/eesupool_repo.dart';

class ChatsTab extends StatelessWidget {
  const ChatsTab({super.key, required this.pool});
  final EESUpool pool;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(context.read<EESUpoolRepository>())
        ..add(ChatStreamStarted(pool.eesupoolId!)),
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
                          padding: const EdgeInsets.only(bottom: 100),
                          itemBuilder: (context, index) {
                            final chat = chats[index];
                            return ChatMessageBubble(
                              message: chat,
                              tags: [],
                              isAdmin: false,
                            );
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
          );
        },
      ),
    );
  }
}

class _Encryption extends StatelessWidget {
  const _Encryption({super.key});

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
