import 'package:data/direct_messages/direct_messages_repository.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';

/// Pick a person to message. Pops with (conversationId, name) once the
/// conversation exists.
class NewConversationScreen extends StatefulWidget {
  const NewConversationScreen({super.key});

  @override
  State<NewConversationScreen> createState() => _NewConversationScreenState();
}

class _NewConversationScreenState extends State<NewConversationScreen> {
  final _controller = TextEditingController();
  List<DmUser> _results = const [];
  bool _searching = false;
  bool _starting = false;

  @override
  void dispose() {
    EasyDebounce.cancel('dm_user_search');
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    if (value.trim().length < 3) {
      EasyDebounce.cancel('dm_user_search');
      setState(() {
        _results = const [];
        _searching = false;
      });
      return;
    }
    EasyDebounce.debounce(
      'dm_user_search',
      const Duration(milliseconds: 400),
      () => _search(value.trim()),
    );
  }

  Future<void> _search(String query) async {
    setState(() => _searching = true);
    final result =
        await context.read<DirectMessagesRepository>().searchUsers(query);
    if (!mounted) return;
    result.fold(
      (l) {
        setState(() => _searching = false);
        context.snackBarError(l.message);
      },
      (r) => setState(() {
        _results = r;
        _searching = false;
      }),
    );
  }

  Future<void> _pick(DmUser user) async {
    if (_starting) return;
    setState(() => _starting = true);
    final result = await context
        .read<DirectMessagesRepository>()
        .startConversation(user.userId);
    if (!mounted) return;
    setState(() => _starting = false);
    result.fold(
      (l) => context.snackBarError(l.message),
      (id) => Navigator.of(context).pop((id, user.fullName)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('New message'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _controller,
              autofocus: true,
              onChanged: _onChanged,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search by name (at least 3 letters)',
              ),
            ),
          ),
          if (_searching || _starting) const LinearProgressIndicator(),
          Expanded(
            child: ListView.builder(
              itemCount: _results.length,
              itemBuilder: (context, i) {
                final u = _results[i];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      u.fullName.isEmpty ? '?' : u.fullName[0].toUpperCase(),
                    ),
                  ),
                  title: Text(u.fullName),
                  onTap: () => _pick(u),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
