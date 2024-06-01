import 'dart:io';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/eesupools/models/chat_message.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/views/eesupools/bloc/eesupool_view_bloc.dart';
import 'package:ui/src/views/eesupools/ui/tabs/chats/bloc/chat_textfield_bloc.dart';
import 'package:ui/src/views/eesupools/ui/tabs/chats/ui/chat_text_field/local_files.dart';
import 'package:ui/src/views/eesupools/ui/tabs/chats/ui/chat_text_field/review_suggestion_topics_dialog.dart';
import 'package:ui/src/views/eesupools/ui/tabs/chats/ui/chat_text_field/suggest_topic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:file_picker/file_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ui/src/views/eesupools/ui/tabs/chats/ui/chat_text_field/topic_suggestions.dart';
import 'package:ui/src/views/eesupools/ui/tabs/chats/ui/widgets/message_text.dart';
import 'package:ui/src/views/eesupools/ui/tabs/chats/ui/widgets/review_messages.dart';
import 'package:ui/src/views/eesupools/ui/tabs/issues/ui/create_issue_dialog.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({super.key, required this.pool});
  final EESUpool pool;

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final allowableExtensions = [
    'jpg',
    'png',
    'jpeg',
    'pdf',
    'doc',
    'docx',
    'xls',
    'xlsx'
  ];

  Future<List<File>> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: allowableExtensions,
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      return files;
    } else {
      // User canceled the picker
      return [];
    }
  }

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final poolId = widget.pool.eesupoolId;
    final memberId = widget.pool.memberId;
    if (poolId == null || memberId == null) return 0.sW;

    return BlocConsumer<ChatTextFieldBloc, ChatTextFieldState>(
      listener: (context, state) {
        if (state is ChatLoading) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
        }

        if (state is ChatTextFieldError) {
          context.snackBarError(state.exception.message);
        }

        if (state is MessageSentSuccess) {
          controller.clear();
          context.read<ChatTextFieldBloc>().add(ChatBoxReset());
        }
      },
      builder: (context, state) {
        List<File> files = [];
        ChatMessage? replyTo;

        if (state is ChatTextFieldCurrentState) {
          files = [...state.files];
          replyTo = state.replyTo;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ChatTextFieldLocalFiles(files: files),
            if (replyTo != null)
              _ReplyPreview(reply: replyTo, pool: widget.pool),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  10.sW,
                  _chatPopUpMenu(),
                  10.sW,
                  _TextField(
                      controller: controller,
                      onChanged: () {
                        setState(() {});
                      }),
                  IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      context.read<ChatTextFieldBloc>().add(
                            ChatMessageSent(
                              widget.pool,
                              controller.text,
                              const [],
                            ),
                          );
                    },
                    icon: const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Icon(
                        IconlyLight.send,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TopicSuggestions(
              visible: controller.text.contains("#"),
              chatTags: widget.pool.chatTags ?? [],
              controller: controller,
            )
          ],
        );
      },
    ).animate().slideIn(0);
  }

  PopupMenuButton<dynamic> _chatPopUpMenu() {
    return PopupMenuButton(
      // padding: const EdgeInsets.only(bottom: 50),
      child: const Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Icon(Icons.add),
      ),
      itemBuilder: (context) {
        return [
          _optionPopUpOption(
            context,
            'Add files',
            () {
              pickFiles().then((files) {
                if (files.isNotEmpty) {
                  context.read<ChatTextFieldBloc>().add(
                        ChatAttachmentsPicked(files),
                      );
                }
              });
            },
            IconlyLight.image2,
          ),
          if (widget.pool.role == EESUpoolMemberRole.admin)
            _optionPopUpOption(
              context,
              'Review messages',
              () {
                context.showBottomSheetDialog(
                  child: ReviewMessagesDialog(pool: widget.pool),
                );
              },
              IconlyLight.message,
            ),
          if (widget.pool.role == EESUpoolMemberRole.admin)
            _optionPopUpOption(
              context,
              'Add & Review topics',
              () {
                context
                    .showBottomSheetDialog(
                  child: ReviewTopicSuggestionsDialog(
                    pool: widget.pool,
                  ),
                )
                    .then((value) {
                  if (value != null) {
                    final res = value as UpdateTopics;

                    context.read<EESUpoolViewBloc>().add(
                          EESUpoolSettingsUpdated(
                            widget.pool.copyWith(
                              chatTags: res.current,
                              chatTagsSuggestions: res.suggestions,
                            ),
                          ),
                        );
                  }
                });
              },
              BootstrapIcons.hash,
            ),
          _optionPopUpOption(
            context,
            'Suggest a topic',
            () {
              context
                  .showBottomSheetDialog(
                child: SuggestTopicDialog(
                  pool: widget.pool,
                ),
              )
                  .then((value) {
                if (value != null) {
                  if (value is List<String>) {
                    context.read<EESUpoolViewBloc>().add(
                          EESUpoolSettingsUpdated(
                            widget.pool.copyWith(
                              chatTagsSuggestions: value,
                            ),
                          ),
                        );
                  }
                }
              });
            },
            BootstrapIcons.hash,
          ),
          _optionPopUpOption(
            context,
            'Report',
            () {
              context.showBottomSheetDialog(
                child: CreateIssueDialog(message: null, pool: widget.pool),
              );
            },
            BootstrapIcons.flag,
          ),
        ];
      },
    );
  }

  PopupMenuItem<dynamic> _optionPopUpOption(
    BuildContext context,
    String label,
    VoidCallback onTap,
    IconData icon,
  ) {
    return PopupMenuItem(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.black, size: 15),
          10.sW,
          Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({required this.controller, required this.onChanged});
  final TextEditingController controller;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        padding: const EdgeInsets.only(left: 10, right: 5),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade200,
            width: .6,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadiusDirectional.circular(10),
        ),
        child: TextField(
          maxLines: null,
          controller: controller,
          onChanged: (value) {
            onChanged.call();
          },
          style: context.textTheme.bodySmall?.copyWith(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 1 == 1 ? 'Say something' : 'The admin has disabled chat',
            hintStyle: context.textTheme.bodySmall?.copyWith(
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

class _ReplyPreview extends StatelessWidget {
  const _ReplyPreview({required this.reply, required this.pool});
  final ChatMessage reply;
  final EESUpool pool;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: const EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(
            color: context.colorScheme.primary,
            width: 4,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.flip(
                    flipY: true,
                    flipX: true,
                    child: const Icon(
                      BootstrapIcons.reply_all,
                    ),
                  ),
                  5.sW,
                  const Text('Replying'),
                ],
              ),
              // if (reply.media != null)
              //   Expanded(child: MessageAttachments(mediaFiles: reply.media!)),
              if (reply.content != null)
                MessageText(
                  message: reply,
                  pool: pool,
                  padding: const EdgeInsets.only(left: 30, bottom: 10),
                )
            ],
          ),
          IconButton(
            onPressed: () {
              context.read<ChatTextFieldBloc>().add(
                    ChatMessageReplyToRemoved(),
                  );
            },
            icon: const Icon(
              Icons.close_outlined,
              color: Colors.redAccent,
            ),
          )
        ],
      ),
    ).animate().slideIn(0);
  }
}
