import 'dart:async';

import 'package:data/eesupools/repository/eesupool_members_repo.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';

class InviteMembersDialog extends StatefulWidget {
  const InviteMembersDialog({
    super.key,
    required this.isNewPool,
    required this.poolId,
  });
  final bool isNewPool;
  final int poolId;

  @override
  State<InviteMembersDialog> createState() => _InviteMembersDialogState();
}

class _InviteMembersDialogState extends State<InviteMembersDialog> {
  final _searchController = TextEditingController();
  Timer? _debounceTimer;
  List<Map<String, dynamic>>? _searchResults;
  bool _isSearching = false;
  String? _searchError;
  final Set<String> _pendingOperations = {};

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      setState(() {
        _searchResults = null;
        _isSearching = false;
        _searchError = null;
      });
      return;
    }

    setState(() => _isSearching = true);

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final repo = context.read<EESUpoolRepository>();
      final result = await repo.searchProfileForInvites(
        query,
        widget.poolId,
        25,
      );

      if (!mounted) return;

      result.fold(
        (error) => setState(() {
          _searchError = error.message;
          _searchResults = null;
          _isSearching = false;
        }),
        (data) => setState(() {
          _searchResults = List<Map<String, dynamic>>.from(data as List);
          _searchError = null;
          _isSearching = false;
        }),
      );
    });
  }

  void _refreshSearch() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _onSearchChanged(query);
    }
  }

  void _handleBackPressed() {
    if (widget.isNewPool) {
      // Pop both screens safely
      final navigator = Navigator.of(context);
      navigator.pop();
      if (navigator.canPop()) {
        navigator.pop();
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: _handleBackPressed),
        title: Transform.scale(
          scale: .94,
          child: EESUpTextFormField(
            hintText: 'SEARCH REFERRAL CODE, FIRST NAME, LAST NAME..',
            controller: _searchController,
            onChanged: _onSearchChanged,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_searchController.text.isEmpty) {
      return FullScreenError(
        isError: false,
        exception: EESUpException(message: 'Search for people'),
      );
    }

    if (_isSearching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_searchError != null) {
      return FullScreenError(
        exception: EESUpException(message: _searchError!),
      );
    }

    if (_searchResults == null || _searchResults!.isEmpty) {
      return FullScreenError(
        isError: false,
        exception: EESUpException(message: 'No results found'),
      );
    }

    return ListView.builder(
      itemCount: _searchResults!.length,
      itemBuilder: (context, index) {
        return _resultsItem(_searchResults![index], context);
      },
    );
  }

  ListTile _resultsItem(Map<String, dynamic> item, BuildContext context) {
    final fullName = item['full_name'] as String?;
    final corporateName = item['corporate_name'] as String?;
    final displayName = fullName ?? corporateName ?? 'Unknown';
    final firstLetter = displayName.isNotEmpty ? displayName[0] : '?';

    return ListTile(
      contentPadding: const EdgeInsets.only(left: 18, right: 8),
      leading: CircleAvatar(
        backgroundColor: Colors.grey.shade200,
        child: Text(firstLetter),
      ),
      title: Text(displayName),
      subtitle: Text(
        item['role'] as String? ?? "~",
        style: context.textTheme.labelSmall?.copyWith(
          color: Colors.grey.shade500,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item['status'] == 'pending')
            _AcceptInvite(
              onRequestSetState: _refreshSearch,
              poolId: widget.poolId,
              item: item,
              pendingOperations: _pendingOperations,
            ),
          if (item['status'] != null)
            _RevokeInvite(
              onRequestSetState: _refreshSearch,
              poolId: widget.poolId,
              item: item,
              pendingOperations: _pendingOperations,
            ),
          if (item['status'] == null)
            _SendInvite(
              onRequestSetState: _refreshSearch,
              item: item,
              poolId: widget.poolId,
              pendingOperations: _pendingOperations,
            ),
        ],
      ),
    );
  }
}

class _SendInvite extends StatelessWidget {
  const _SendInvite({
    required this.onRequestSetState,
    required this.item,
    required this.poolId,
    required this.pendingOperations,
  });
  final VoidCallback onRequestSetState;
  final int poolId;
  final Map<String, dynamic> item;
  final Set<String> pendingOperations;

  @override
  Widget build(BuildContext context) {
    final userId = item['user_id'] as String?;
    final displayName =
        item['full_name'] as String? ?? item['corporate_name'] as String? ?? 'User';
    final isPending = userId != null && pendingOperations.contains(userId);

    return TextButton(
      onPressed: isPending
          ? null
          : () async {
              if (item['membership_id'] != null) {
                context.snackBarError(
                  '$displayName is already a member of this EESUpool',
                );
                return;
              }

              if (item['status'] != null) {
                context.snackBarError(
                  '$displayName already has an invite or a request to join this EESUpool',
                );
                return;
              }

              if (userId == null) {
                context.snackBarError('Invalid user');
                return;
              }

              // Prevent double-tap
              pendingOperations.add(userId);

              final repo = context.read<EESUpoolRepository>();
              context.loaderOverlay.show();
              final result = await repo.createEESUpoolInvite(
                poolId,
                userId,
                'Invite',
              );

              pendingOperations.remove(userId);

              if (!context.mounted) return;
              context.loaderOverlay.hide();

              result.fold((l) {
                context.snackBarError(
                  '$displayName has already been invited to join this EESUpool',
                );
              }, (r) {
                context.snackBarSuccess(
                  '$displayName has been invited to join this EESUpool',
                );
                onRequestSetState.call();
              });
            },
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: isPending
            ? const SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Text('Invite'),
      ),
    );
  }
}

class _RevokeInvite extends StatelessWidget {
  const _RevokeInvite({
    required this.onRequestSetState,
    required this.item,
    required this.poolId,
    required this.pendingOperations,
  });
  final VoidCallback onRequestSetState;
  final int poolId;
  final Map<String, dynamic> item;
  final Set<String> pendingOperations;

  @override
  Widget build(BuildContext context) {
    final userId = item['user_id'] as String?;
    final displayName =
        item['full_name'] as String? ?? item['corporate_name'] as String? ?? 'User';
    final isPending = userId != null && pendingOperations.contains('revoke_$userId');

    return TextButton(
      onPressed: isPending
          ? null
          : () async {
              if (item['membership_id'] != null) {
                context.snackBarError(
                  '$displayName is already a member of this EESUpool',
                );
                return;
              }

              if (userId == null) {
                context.snackBarError('Invalid user');
                return;
              }

              // Prevent double-tap
              pendingOperations.add('revoke_$userId');

              final repo = context.read<EESUpoolRepository>();
              context.loaderOverlay.show();
              final result = await repo.deleteInviteOrRequest(userId, poolId);

              pendingOperations.remove('revoke_$userId');

              if (!context.mounted) return;
              context.loaderOverlay.hide();

              result.fold((l) {
                context.snackBarError('Failed to revoke the invite');
              }, (r) {
                context.snackBarSuccess('Invite revoked');
                onRequestSetState.call();
              });
            },
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: isPending
            ? const SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Text(
                'Revoke',
                style: TextStyle(color: Colors.red),
              ),
      ),
    );
  }
}

class _AcceptInvite extends StatelessWidget {
  const _AcceptInvite({
    required this.onRequestSetState,
    required this.item,
    required this.poolId,
    required this.pendingOperations,
  });
  final VoidCallback onRequestSetState;
  final int poolId;
  final Map<String, dynamic> item;
  final Set<String> pendingOperations;

  @override
  Widget build(BuildContext context) {
    final userId = item['user_id'] as String?;
    final displayName =
        item['full_name'] as String? ?? item['corporate_name'] as String? ?? 'User';
    final isPending = userId != null && pendingOperations.contains('accept_$userId');

    return TextButton(
      onPressed: isPending
          ? null
          : () async {
              if (userId == null) {
                context.snackBarError('Invalid user');
                return;
              }

              // Prevent double-tap
              pendingOperations.add('accept_$userId');

              final repo = context.read<EESUpoolRepository>();
              context.loaderOverlay.show();
              final result = await repo.updateEESUpoolRequest(
                userId,
                poolId,
                'Accepted',
              );

              pendingOperations.remove('accept_$userId');

              if (!context.mounted) return;
              context.loaderOverlay.hide();

              result.fold((l) {
                context.snackBarError('Failed to accept the invite');
              }, (r) {
                context.snackBarSuccess(
                  '$displayName has been accepted to join this EESUpool',
                );
                onRequestSetState.call();
              });
            },
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: isPending
            ? const SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Text('Accept'),
      ),
    );
  }
}
