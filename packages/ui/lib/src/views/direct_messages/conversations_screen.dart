import 'dart:async';

import 'package:data/direct_messages/direct_messages_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/views/direct_messages/conversation_screen.dart';
import 'package:ui/src/views/direct_messages/new_conversation_screen.dart';

/// The user's direct-message conversations. Updates live when a message
/// arrives, is approved or is read.
class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({super.key});

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  List<DmConversation>? _conversations;
  String? _error;
  StreamSubscription<void>? _changes;

  DirectMessagesRepository get _repo => context.read<DirectMessagesRepository>();

  @override
  void initState() {
    super.initState();
    _load();
    _changes = _repo.messageChanges().listen((_) => _load());
  }

  @override
  void dispose() {
    _changes?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    final result = await _repo.fetchConversations();
    if (!mounted) return;
    result.fold(
      (l) => setState(() => _error = l.message),
      (r) => setState(() {
        _conversations = r;
        _error = null;
      }),
    );
  }

  Future<void> _open(String conversationId, String name) async {
    await Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (_) => ConversationScreen(
        conversationId: conversationId,
        otherName: name,
      ),
    ));
    _load();
  }

  Future<void> _startNew() async {
    final picked = await Navigator.of(context).push<(String, String)>(
      MaterialPageRoute(builder: (_) => const NewConversationScreen()),
    );
    if (picked != null && mounted) _open(picked.$1, picked.$2);
  }

  @override
  Widget build(BuildContext context) {
    final conversations = _conversations;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Messages'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _startNew,
        icon: const Icon(Icons.edit_outlined),
        label: const Text('New message'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: context.bgImage,
        child: () {
          if (conversations == null) {
            return Center(
              child: _error != null
                  ? Text(_error!)
                  : const CircularProgressIndicator(),
            );
          }
          if (conversations.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  'No conversations yet. Start one with "New message".',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.only(bottom: 90),
            itemCount: conversations.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final c = conversations[i];
              return ListTile(
                onTap: () => _open(c.id, c.otherName),
                leading: CircleAvatar(
                  backgroundColor: context.colorScheme.primary.withOpacity(.1),
                  child: Text(
                    c.otherName.isEmpty ? '?' : c.otherName[0].toUpperCase(),
                  ),
                ),
                title: Text(
                  c.otherName,
                  style: TextStyle(
                    fontWeight:
                        c.unreadCount > 0 ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  c.lastMessage ?? 'No messages yet',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: c.unreadCount > 0
                    ? CircleAvatar(
                        radius: 11,
                        backgroundColor: context.colorScheme.primary,
                        child: Text(
                          '${c.unreadCount}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : null,
              );
            },
          );
        }(),
      ),
    );
  }
}
