import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:countup/countup.dart';
import 'package:data/eesupools/models/chat_message.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/animated_reaction_btn.dart';
import 'package:ui/src/views/eesupools/ui/tabs/chats/bloc/chat_bloc.dart';

class MessageReaction extends StatelessWidget {
  const MessageReaction({
    super.key,
    required this.pool,
    required this.message,
    this.onReaction,
  });

  final EESUpool pool;
  final void Function()? onReaction;
  final ChatMessage message;

  int get likes =>
      message.reactions?.where((element) => element.liked).length ?? 0;

  int get dislikes =>
      message.reactions?.where((element) => !element.liked).length ?? 0;

  bool reacted(String? sessionId) {
    bool reacted = false;

    message.reactions?.forEach((element) {
      if (element.memberId == sessionId) {
        reacted = true;
      } else {
        reacted = false;
      }
    });

    return reacted;
  }

  bool liked(String? sessionId) {
    bool liked = false;

    message.reactions?.forEach((element) {
      if (element.memberId == sessionId) {
        if (element.liked) {
          liked = true;
        }
      } else {
        liked = false;
      }
    });

    return liked;
  }

  bool disliked(String? sessionId) {
    bool disliked = false;

    message.reactions?.forEach((element) {
      if (element.memberId == sessionId) {
        if (!element.liked) {
          disliked = true;
        }
      } else {
        disliked = false;
      }
    });

    return disliked;
  }

  @override
  Widget build(BuildContext context) {
    final memberId = pool.memberId;
    return Row(
      children: [
        5.sW,
        AnimatedReactionButton(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                liked(memberId)
                    ? BootstrapIcons.hand_thumbs_up_fill
                    : BootstrapIcons.hand_thumbs_up,
                color:
                    liked(memberId) ? context.colorScheme.primary : Colors.grey,
                size: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Countup(
                    begin: 0,
                    end: likes.toDouble(),
                    duration: 300.ms,
                    separator: ',',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          onTap: () {
            if (memberId == null) return;

            context.read<ChatBloc>().add(
                  MessageReactionAdded(
                    pool.eesupoolId!,
                    message.id,
                    memberId,
                    true,
                  ),
                );
          },
        ),
        const SizedBox(width: 5),
        AnimatedReactionButton(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // AnimatedReactiionButton(),
              Icon(
                disliked(memberId)
                    ? BootstrapIcons.hand_thumbs_down_fill
                    : BootstrapIcons.hand_thumbs_down,
                color: disliked(memberId) ? Colors.redAccent : Colors.grey,
                size: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Countup(
                    begin: 0,
                    end: dislikes.toDouble(),
                    duration: 300.ms,
                    separator: ',',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          onTap: () {
            if (memberId == null) return;

            context.read<ChatBloc>().add(
                  MessageReactionAdded(
                    pool.eesupoolId!,
                    message.id,
                    memberId,
                    false,
                  ),
                );
          },
        ),
      ],
    );
  }
}
