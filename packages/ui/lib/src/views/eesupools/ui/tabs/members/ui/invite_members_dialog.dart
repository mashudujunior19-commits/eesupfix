// ignore_for_file: use_build_context_synchronously

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

  @override
  Widget build(BuildContext context) {
    final repo = context.read<EESUpoolRepository>();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            if (widget.isNewPool) {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        title: Transform.scale(
          scale: .94,
          child: EESUpTextFormField(
            hintText: 'SEARCH REFERRAL CODE, FIRST NAME, LAST NAME..',
            controller: _searchController,
            onChanged: (v) {
              setState(() {});
            },
          ),
        ),
      ),
      body: () {
        if (_searchController.text.isNotEmpty) {
          return FutureBuilder(
            future: repo.searchProfileForInvites(
              _searchController.text,
              widget.poolId,
              25,
            ),
            builder: (context, snap) {
              if (snap.data != null) {
                return snap.data!.fold(
                  (left) {
                    return FullScreenError(exception: left);
                  },
                  (right) {
                    return ListView.builder(
                      itemCount: right.length,
                      itemBuilder: (context, index) {
                        return _resultsItem(right[index], context);
                      },
                    );
                  },
                );
              } else {
                return FullScreenError(
                  isError: false,
                  exception: EESUpException(message: 'Search for people'),
                );
              }
            },
          );
        } else {
          return FullScreenError(
            isError: false,
            exception: EESUpException(message: 'Search for people'),
          );
        }
      }(),
    );
  }

  ListTile _resultsItem(item, BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 18, right: 8),
      leading: CircleAvatar(
        backgroundColor: Colors.grey.shade200,
        child: Text(item['full_name']?[0] ?? item['corporate_name']?[0]),
      ),
      title: Text(
        item['full_name'] ?? item['corporate_name'],
      ),
      subtitle: Text(
        item['role'] ?? "~",
        style: context.textTheme.labelSmall?.copyWith(
          color: Colors.grey.shade500,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item['status'] == 'pending')
            _AcceptInvite(
              onRequestSetState: () {
                setState(() {});
              },
              poolId: widget.poolId,
              item: item,
            ),
          if (item['status'] != null)
            _RevokeInvite(
                onRequestSetState: () {
                  setState(() {});
                },
                poolId: widget.poolId,
                item: item),
          if (item['status'] == null)
            _SendInvite(
              onRequestSetState: () {
                setState(() {});
              },
              item: item,
              poolId: widget.poolId,
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
  });
  final VoidCallback onRequestSetState;
  final int poolId;
  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Padding(
        padding: EdgeInsets.only(
          right: 15,
        ),
        child: Text('Invite'),
      ),
      onPressed: () async {
        if (item['membership_id'] != null) {
          context.snackBarError(
            '${item['full_name'] ?? item['corporate_name']} is already a member of this EESUpool',
          );
          return;
        }

        if (item['status'] != null) {
          context.snackBarError(
            '${item['full_name'] ?? item['corporate_name']} already has an invite or a request to join this EESUpool',
          );
          return;
        }
        final repo = context.read<EESUpoolRepository>();

        context.loaderOverlay.show();
        final result = await repo.createEESUpoolInvite(
          poolId,
          item['user_id'],
          'Invite',
        );
        context.loaderOverlay.hide();

        result.fold((l) {
          context.snackBarError(
            '${item['full_name'] ?? item['corporate_name']} has already been invited to join this EESUpool',
          );
        }, (r) {
          context.snackBarSuccess(
            '${item['full_name'] ?? item['corporate_name']} has been invited to join this EESUpool',
          );

          onRequestSetState.call();
        });
      },
    );
  }
}

class _RevokeInvite extends StatelessWidget {
  const _RevokeInvite({
    required this.onRequestSetState,
    required this.item,
    required this.poolId,
  });
  final VoidCallback onRequestSetState;
  final int poolId;
  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Padding(
        padding: EdgeInsets.only(
          right: 15,
        ),
        child: Text(
          'Revoke',
          style: TextStyle(color: Colors.red),
        ),
      ),
      onPressed: () async {
        if (item['membership_id'] != null) {
          context.snackBarError(
            '${item['full_name'] ?? item['corporate_name']} is already a member of this EESUpool',
          );
          return;
        }
        final repo = context.read<EESUpoolRepository>();
        context.loaderOverlay.show();
        final result =
            await repo.deleteInviteOrRequest(item['user_id'], poolId);
        context.loaderOverlay.hide();

        result.fold((l) {
          context.snackBarError('Failed to revoke the invite');
        }, (r) {
          context.snackBarSuccess('Invite revoked');
          onRequestSetState.call();
        });
      },
    );
  }
}

class _AcceptInvite extends StatelessWidget {
  const _AcceptInvite({
    required this.onRequestSetState,
    required this.item,
    required this.poolId,
  });
  final VoidCallback onRequestSetState;
  final int poolId;
  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Padding(
        padding: EdgeInsets.only(
          right: 15,
        ),
        child: Text('Accept'),
      ),
      onPressed: () async {
        final repo = context.read<EESUpoolRepository>();

        context.loaderOverlay.show();
        final result = await repo.updateEESUpoolRequest(
            item['user_id'], poolId, 'Accepted');
        context.loaderOverlay.hide();

        result.fold((l) {
          context.snackBarError('Failed to accept the invite');
        }, (r) {
          context.snackBarSuccess(
            '${item['full_name'] ?? item['corporate_name']} has been accepted to join this EESUpool',
          );

          onRequestSetState.call();
        });
      },
    );
  }
}
