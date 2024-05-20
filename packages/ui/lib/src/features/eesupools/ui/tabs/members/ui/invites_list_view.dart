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
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';

class InviteMembersDialog extends StatefulWidget {
  const InviteMembersDialog({super.key, required this.poolId});
  final int poolId;

  @override
  State<InviteMembersDialog> createState() => _InviteMembersDialogState();
}

class _InviteMembersDialogState extends State<InviteMembersDialog> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
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
          FutureBuilder(
            future: context.read<EESUpoolRepository>().searchProfileForInvites(
                  _searchController.text,
                  widget.poolId,
                  25,
                ),
            builder: (context, snap) {
          
              if (snap.hasData) {
                final data = (snap.data as List);
                return ListView.builder(
                  itemCount: data.length,
                  padding: const EdgeInsets.only(bottom: 300),
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return _resultsItem(item, context);
                  },
                );
              } else if (snap.connectionState == ConnectionState.waiting) {
                return const FullScreenLoadingShimmer();
              } else {
                return FullScreenError(
                  isError: false,
                  exception: EESUpException(message: 'Search for members'),
                );
              }
            },
          );
        } else {
          return FullScreenError(
            isError: false,
            exception: EESUpException(message: 'Search for members'),
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
      trailing: item['status'] != null
          ? TextButton(
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
                final result = await repo.deleteInviteOrRequest(
                  item['user_id'],
                  widget.poolId,
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
                });
              },
            )
          : TextButton(
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
                  widget.poolId,
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

                  setState(() {});
                });
              },
            ),
    );
  }
}
