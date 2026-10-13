import 'dart:async';

import 'package:data/direct_messages/direct_messages_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';

enum _SendStatus { sending, failed }

/// A message the user just sent that the server has not confirmed yet.
class _Pending {
  _Pending(this.localId, this.text);
  final String localId;
  final String text;
  _SendStatus status = _SendStatus.sending;
}

/// One-to-one chat with realtime delivery. Sent messages appear at once as
/// "sending" and turn into the real message (or a retryable error).
class ConversationScreen extends StatefulWidget {
  const ConversationScreen({
    super.key,
    required this.conversationId,
    required this.otherName,
  });
  final String conversationId;
  final String otherName;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final _controller = TextEditingController();
  final _pending = <_Pending>[];

  /// Messages the server accepted, kept until the realtime stream lists them.
  final _confirmed = <DmMessage>[];
  List<DmMessage> _streamed = const [];
  StreamSubscription<List<DmMessage>>? _sub;

  DirectMessagesRepository get _repo => context.read<DirectMessagesRepository>();

  @override
  void initState() {
    super.initState();
    _sub = _repo.streamMessages(widget.conversationId).listen((messages) {
      if (!mounted) return;
      setState(() {
        _streamed = messages;
        final ids = messages.map((m) => m.id).toSet();
        _confirmed.removeWhere((m) => ids.contains(m.id));
      });
      _markReadIfNeeded(messages);
    });
    _repo.markRead(widget.conversationId);
  }

  @override
  void dispose() {
    _sub?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _markReadIfNeeded(List<DmMessage> messages) {
    final me = _repo.currentUserId;
    final hasUnread =
        messages.any((m) => m.senderId != me && m.readAt == null);
    if (hasUnread) _repo.markRead(widget.conversationId);
  }

  List<DmMessage> get _visible {
    final ids = _streamed.map((m) => m.id).toSet();
    final all = [..._streamed, ..._confirmed.where((m) => !ids.contains(m.id))]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return all;
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();
    final pending = _Pending('local_${DateTime.now().microsecondsSinceEpoch}', text);
    setState(() => _pending.add(pending));
    _deliver(pending);
  }

  Future<void> _deliver(_Pending pending) async {
    setState(() => pending.status = _SendStatus.sending);
    final result =
        await _repo.sendMessage(widget.conversationId, pending.text);
    if (!mounted) return;
    result.fold(
      (l) => setState(() => pending.status = _SendStatus.failed),
      (message) {
        setState(() {
          _pending.remove(pending);
          _confirmed.add(message);
        });
        if (!message.isApproved) {
          context.snackBarWarning(
            'Your message is pending review. An admin will check it before '
            'it is delivered.',
          );
        }
      },
    );
  }

  Future<void> _report(DmMessage message) async {
    final result = await _repo.reportMessage(message.id);
    if (!mounted) return;
    result.fold(
      (l) => context.snackBarError(l.message),
      (_) => context.snackBarSuccess('Reported. An admin will review it.'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final me = _repo.currentUserId;
    final visible = _visible;
    final pending = _pending.reversed.toList();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(widget.otherName),
      ),
      body: Container(
        decoration: context.bgImage,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
                itemCount: pending.length + visible.length,
                itemBuilder: (context, i) {
                  if (i < pending.length) {
                    return _PendingBubble(
                      pending: pending[i],
                      onRetry: () => _deliver(pending[i]),
                      onDelete: () =>
                          setState(() => _pending.remove(pending[i])),
                    );
                  }
                  final m = visible[i - pending.length];
                  return _Bubble(
                    message: m,
                    mine: m.senderId == me,
                    onReport: m.senderId == me ? null : () => _report(m),
                  );
                },
              ),
            ),
            SafeArea(
              top: false,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(12, 6, 6, 6),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        minLines: 1,
                        maxLines: 5,
                        maxLength: 2000,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          hintText: 'Message',
                          counterText: '',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _send,
                      icon: Icon(Icons.send, color: context.colorScheme.primary),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.message, required this.mine, this.onReport});
  final DmMessage message;
  final bool mine;
  final VoidCallback? onReport;

  String? _statusNote() {
    if (!mine) return null;
    if (message.isDeleted) return 'Not delivered';
    if (!message.isApproved) {
      return message.moderationStatus == 'flagged'
          ? 'Under review'
          : 'Pending review. An admin will check it before it is delivered.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final note = _statusNote();
    return GestureDetector(
      onLongPress: onReport == null
          ? null
          : () async {
              final report = await showModalBottomSheet<bool>(
                context: context,
                builder: (_) => SafeArea(
                  child: ListTile(
                    leading: const Icon(Icons.flag_outlined),
                    title: const Text('Report this message'),
                    onTap: () => Navigator.pop(context, true),
                  ),
                ),
              );
              if (report == true) onReport!();
            },
      child: Align(
        alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * .75,
          ),
          decoration: BoxDecoration(
            color: mine ? Colors.blue.shade50 : Colors.white.withOpacity(.85),
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message.content),
              if (note != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    note,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PendingBubble extends StatelessWidget {
  const _PendingBubble({
    required this.pending,
    required this.onRetry,
    required this.onDelete,
  });
  final _Pending pending;
  final VoidCallback onRetry;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final failed = pending.status == _SendStatus.failed;
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width * .75,
            ),
            decoration: BoxDecoration(
              color: Colors.blue.shade50.withOpacity(.6),
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(pending.text),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3, right: 4),
            child: failed
                ? Wrap(
                    spacing: 12,
                    children: [
                      Text(
                        'Not sent',
                        style: context.textTheme.labelSmall
                            ?.copyWith(color: Colors.redAccent),
                      ),
                      InkWell(
                        onTap: onRetry,
                        child: Text(
                          'Retry',
                          style: context.textTheme.labelMedium
                              ?.copyWith(color: context.colorScheme.primary),
                        ),
                      ),
                      InkWell(
                        onTap: onDelete,
                        child: Text(
                          'Delete',
                          style: context.textTheme.labelMedium
                              ?.copyWith(color: Colors.redAccent),
                        ),
                      ),
                    ],
                  )
                : Text(
                    'Sending...',
                    style: context.textTheme.labelSmall
                        ?.copyWith(color: Colors.grey),
                  ),
          ),
        ],
      ),
    );
  }
}
