import 'package:data/eesupools/models/chat_message.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_issue.dart';
import 'package:data/eesupools/repository/eesupool_chats_repo.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/features/eesupools/ui/tabs/chats/ui/widgets/message_bubble.dart';

class CreateIssueDialog extends StatelessWidget {
  CreateIssueDialog({
    super.key,
    required this.message,
    required this.pool,
  });
  final EESUpool pool;
  final ChatMessage? message;
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Create Issue'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 300,
        ),
        children: [
          if (message != null) _MessagePreview(message: message!, pool: pool),
          10.sH,
          EESUpTextFormField(
            label: 'Description',
            hintText: 'Describe the issue',
            maxLines: 8,
            controller: _textController,
          ),
          20.sH,
          ElevatedButton(
            onPressed: () async {
              if (_textController.text.isEmpty) return;
              FocusScope.of(context).unfocus();
              final repo = context.read<EESUpoolRepository>();
              context.loaderOverlay.show();

              final results = await repo.reportIssue(
                EESUpoolIssue(
                  id: '',
                  eesupoolId: pool.eesupoolId!,
                  parentPoolId: pool.parentId,
                  createdAt: DateTime.now(),
                  description: _textController.text,
                  reporterId: pool.memberId,
                  offenderId: message?.authorId,
                  chatMessageId: message?.id,
                ),
              );
              // ignore: use_build_context_synchronously
              context.loaderOverlay.hide();

              results.fold((left) {
                context.snackBarError(left.message);
              }, (right) {
                context.snackBarSuccess('Issue captured.');
                Navigator.pop(context);
              });
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class _MessagePreview extends StatelessWidget {
  const _MessagePreview({required this.message, required this.pool});

  final ChatMessage message;
  final EESUpool pool;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Report this message',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: 16,
                color: Colors.black.withOpacity(.9),
              ),
        ),
        MessageBubble(
          message: message,
          pool: pool,
        ),
      ],
    );
  }
}
