import 'package:data/direct_messages/direct_messages_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';

/// Review queue for direct messages that were held by the moderation filter or
/// reported by a recipient. Only app admins can load it (the database enforces
/// this); the menu only shows the entry to them.
class DmReviewScreen extends StatefulWidget {
  const DmReviewScreen({super.key});

  @override
  State<DmReviewScreen> createState() => _DmReviewScreenState();
}

class _DmReviewScreenState extends State<DmReviewScreen> {
  List<HeldDm>? _items;
  String? _error;

  DirectMessagesRepository get _repo => context.read<DirectMessagesRepository>();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final result = await _repo.fetchHeldMessages();
    if (!mounted) return;
    result.fold(
      (l) => setState(() => _error = l.message),
      (r) => setState(() {
        _items = r;
        _error = null;
      }),
    );
  }

  Future<void> _review(HeldDm item, bool approve) async {
    final result = await _repo.reviewMessage(item.messageId, approve: approve);
    if (!mounted) return;
    result.fold(
      (l) => context.snackBarError(l.message),
      (_) {
        setState(() => _items?.remove(item));
        context.snackBarSuccess(approve ? 'Message delivered' : 'Message rejected');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _items;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Message review'),
      ),
      body: () {
        if (items == null) {
          return Center(
            child: _error != null
                ? Text(_error!)
                : const CircularProgressIndicator(),
          );
        }
        if (items.isEmpty) {
          return const Center(child: Text('Nothing waiting for review.'));
        }
        return RefreshIndicator(
          onRefresh: _load,
          child: ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: items.length,
            itemBuilder: (context, i) {
              final m = items[i];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'From ${m.senderName}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      Text(m.content),
                      if (m.reason != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            m.reason!,
                            style: const TextStyle(
                              color: Colors.orange,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () => _review(m, true),
                            child: const Text('Approve'),
                          ),
                          TextButton(
                            onPressed: () => _review(m, false),
                            child: const Text(
                              'Reject',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }(),
    );
  }
}
