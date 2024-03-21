import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'text_field_options_pop_up.dart';
import 'text_field_media.dart';
import 'text_field_reply_chat.dart';

class ChatTextField extends ConsumerStatefulWidget {
  const ChatTextField({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends ConsumerState<ChatTextField> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  bool showBroadcast = false;

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showBroadcast = true;
        });
      } else {
        setState(() {
          showBroadcast = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pool = ref.watch(eesupoolViewProvider);

    if (pool == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //if (showBroadcast)
        // BroadcastOptionPopUp(),
        const TextFieldMedia(),
        TextFieldReplyChat(tags: pool.chatTags ?? []),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Colors.blueGrey.shade50,
                width: .3,
              ),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const TextFieldOptionsPopUp(),
              _chatTextField(context, pool),
              if (pool.role == EESUpoolMemberRole.admin || pool.chatEnabled)
                Row(
                  children: [
                    if (pool.type != EESUpoolType.trade)
                      if (pool.level != EESUpoolLevel.Street &&
                          pool.role == EESUpoolMemberRole.admin)
                        IconButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            final levels = await showSelectEESUpoolDialog(
                              context,
                              pool.level!,
                            );

                            if (levels != null) {
                              context.loaderOverlay.show();
                              final result = await ref
                                  .read(chatTextFieldProvider.notifier)
                                  .sendMessage(
                                    pool.memberId!,
                                    pool.eesupoolId!,
                                    controller.text,
                                    pool.chatTags ?? [],
                                    //This for when the member sending the message is censored
                                    //The message will be sent as censored
                                    //and wait for the admin to approve it
                                    pool.isCensored == false,
                                    levels as List<EESUpoolLevel>,
                                  );
                              context.loaderOverlay.hide();
                              result.fold(
                                (ex) {
                                  showSnackBar(
                                    context: context,
                                    message: ex.message,
                                    type: SnackBarType.error,
                                  );
                                },
                                (success) {
                                  FocusNode().unfocus();
                                  controller.clear();
                                },
                              );
                            }
                          },
                          icon: Tooltip(
                            message:
                                'Broadcast this message to other EESUpools',
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 13),
                              child: Icon(
                                BootstrapIcons.broadcast,
                                color: Colors.black.withOpacity(.65),
                              ),
                            ),
                          ),
                        ),
                    IconButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        context.loaderOverlay.show();
                        final result = await ref
                            .read(chatTextFieldProvider.notifier)
                            .sendMessage(
                              pool.memberId!,
                              pool.eesupoolId!,

                              controller.text,
                              pool.chatTags ?? [],
                              //This for when the member sending the message is censored
                              //The message will be sent as censored
                              //and wait for the admin to approve it
                              pool.isCensored == false,
                              null,
                            );
                        context.loaderOverlay.hide();
                        result.fold(
                          (ex) {
                            showSnackBar(
                              context: context,
                              message: ex.message,
                              type: SnackBarType.error,
                            );
                          },
                          (success) {
                            FocusNode().unfocus();
                            controller.clear();
                          },
                        );
                      },
                      icon: const Padding(
                        padding: EdgeInsets.only(bottom: 13),
                        child: Icon(
                          IconlyLight.send,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                )
              else
                const SizedBox(width: 15)
            ],
          ),
        ),
        HashTagSuggestions(
          visible: controller.text.contains("#"),
          chatTags: pool.chatTags ?? [],
          controller: controller,
        )
      ],
    );
  }

  Expanded _chatTextField(BuildContext context, EESUpool pool) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme.bodySmall;
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blueGrey.shade200,
            width: .3,
          ),
          borderRadius: BorderRadius.circular(13),
        ),
        child: TextField(
          focusNode: focusNode,
          controller: controller,
          onChanged: (value) {
            setState(() {});
          },
          maxLines: null,
          enabled: pool.chatEnabled || pool.role == EESUpoolMemberRole.admin,
          style: textTheme!.copyWith(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: pool.chatEnabled == true ||
                    pool.role == EESUpoolMemberRole.admin
                ? 'Say something'
                : 'The admin has disabled chat',
            hintStyle: textTheme.copyWith(
              color: Colors.grey.shade200,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
