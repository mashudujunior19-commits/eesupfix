import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/views/eesupools/ui/tabs/chats/bloc/chat_bloc.dart';
import 'package:ui/src/views/eesupools/ui/tabs/chats/bloc/chat_textfield_bloc.dart';
import 'package:ui/src/views/eesupools/ui/tabs/chats/ui/chat_text_field/chat_textfield.dart';
import 'package:ui/src/views/eesupools/ui/tabs/chats/ui/widgets/message_bubble.dart';
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
          create: (context) => ChatTextFieldBloc(),
        ),
      ],
      child: BlocConsumer<ChatBloc, ChatState>(
        listenWhen: (_, current) =>
            current is ChatMessagesLoaded && current.notice != null,
        listener: (context, state) {
          final notice = (state as ChatMessagesLoaded).notice;
          if (notice != null) context.snackBarWarning(notice);
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
                      // The list is reversed (newest at the bottom): messages
                      // still being sent come first, newest of them first.
                      final pending = state.pending.reversed.toList();

                      return Expanded(
                        child: ListView.builder(
                          reverse: true,
                          itemCount: pending.length + chats.length,
                          padding: const EdgeInsets.only(
                              bottom: 40, left: 15, right: 15),
                          itemBuilder: (context, index) {
                            if (index < pending.length) {
                              return _PendingMessage(
                                pending: pending[index],
                                pool: pool,
                              );
                            }
                            final chat = chats[index - pending.length];
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

/// A message the user just sent: shown at once, dimmed while sending, with a
/// retry option if it could not be sent.
class _PendingMessage extends StatelessWidget {
  const _PendingMessage({required this.pending, required this.pool});
  final PendingChatMessage pending;
  final EESUpool pool;

  @override
  Widget build(BuildContext context) {
    final failed = pending.status == PendingStatus.failed;
    final sending = pending.status == PendingStatus.sending;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Opacity(
          opacity: failed || sending ? .6 : 1,
          // Reactions, reply and delete need a real server id.
          child: IgnorePointer(
            child: MessageBubble(message: pending.message, pool: pool),
          ),
        ),
        if (sending)
          Padding(
            padding: const EdgeInsets.only(top: 4, right: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(strokeWidth: 1.5),
                ),
                5.sW,
                Text(
                  'Sending...',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        if (failed)
          Padding(
            padding: const EdgeInsets.only(top: 4, right: 4),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              children: [
                Text(
                  'Not sent',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: Colors.redAccent,
                  ),
                ),
                InkWell(
                  onTap: () => context
                      .read<ChatBloc>()
                      .add(ChatMessageRetried(pending.localId)),
                  child: Text(
                    'Retry',
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => context
                      .read<ChatBloc>()
                      .add(ChatPendingDismissed(pending.localId)),
                  child: Text(
                    'Delete',
                    style: context.textTheme.labelMedium?.copyWith(
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
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
