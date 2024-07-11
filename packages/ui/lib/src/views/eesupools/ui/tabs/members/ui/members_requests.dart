import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/eesupools/models/eesupool_request.dart';
import 'package:data/eesupools/repository/eesupool_members_repo.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/views/eesupools/ui/tabs/members/bloc/members_invites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data/utils/eesup_exception.dart';

class MembersRequests extends StatelessWidget {
  const MembersRequests({super.key, required this.pool});
  final EESUpool pool;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MembersInvitesBloc(context.read<EESUpoolRepository>())
            ..add(MembersInvitesFetched(pool.eesupoolId!, 50, 'Request')),
      child: BlocBuilder<MembersInvitesBloc, MembersInvitesState>(
        builder: (context, state) {
          if (state is MembersInvitesLoading) {
            return const FullScreenLoadingShimmer();
          } else if (state is MembersInvitesLoaded) {
            if (state.invites.isEmpty) {
              return FullScreenError(
                isError: false,
                exception: EESUpException(
                  message: "There are not requests yet.",
                ),
              );
            }
            return ListView.builder(
              itemCount: state.invites.length,
              itemBuilder: (context, index) {
                final invite = state.invites[index];
                return _InviteCard(invite: invite, pool: pool)
                    .animate()
                    .slideIn((50 * index).toDouble());
              },
            );
          } else {
            return FullScreenError(
              exception: EESUpException(
                message: "Something went wrong while getting the members",
              ),
            );
          }
        },
      ),
    );
  }
}

class _InviteCard extends StatefulWidget {
  _InviteCard({required this.invite, required this.pool});
  final EESUpool pool;
  late EESUpoolRequest invite;
  @override
  State<_InviteCard> createState() => _InviteCardState();
}

class _InviteCardState extends State<_InviteCard> {
  @override
  Widget build(BuildContext context) {
    bool accepting = false;
    return Container(
      margin: const EdgeInsets.only(right: 15, left: 15, top: 15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
          width: .5,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 16, right: 10),
        leading: CircleAvatar(
          backgroundColor: context.colorScheme.primary.withOpacity(.1),
          child: Text(widget.invite.fullName?.substring(0, 1) ?? '~'),
        ),
        title:
            Text(widget.invite.fullName ?? widget.invite.corporateName ?? '~'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.invite.role.toString(),
                  style: context.textTheme.labelMedium?.copyWith(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    widget.invite.status,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 9,
                    ),
                  ),
                ),
              ],
            ),
            if (widget.invite.status == 'Pending')
              if (widget.pool.role == EESUpoolMemberRole.admin)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    InkWell(
                      onTap: () async {},
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              setState(() {
                                accepting = true;
                              });
                              final repo = context.read<EESUpoolRepository>();

                              context.loaderOverlay.show();
                              final result = await repo.updateEESUpoolRequest(
                                  widget.invite.userId,
                                  widget.invite.eesupoolId,
                                  'Accepted');
                              context.loaderOverlay.hide();

                              result.fold((l) {
                                context.snackBarError(
                                    'Failed to accept the invite');
                              }, (r) {
                                setState(() {
                                  widget.invite = widget.invite
                                      .copyWith(status: 'Accepted');
                                });

                                context.snackBarSuccess(
                                  '${widget.invite.fullName ?? widget.invite.corporateName} has been accepted to join this EESUpool',
                                );
                              });
                              setState(() {
                                accepting = false;
                              });
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.check,
                                    size: 17, color: Colors.green),
                                SizedBox(width: 5),
                                Text(
                                  "Accept",
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          InkWell(
                            onTap: () async {
                              setState(() {
                                accepting = true;
                              });
                              final repo = context.read<EESUpoolRepository>();
                              context.loaderOverlay.show();
                              final result = await repo.deleteInviteOrRequest(
                                  widget.invite.userId,
                                  widget.invite.eesupoolId);
                              context.loaderOverlay.hide();

                              result.fold((l) {
                                context.snackBarError(
                                    'Failed to revoke the invite');
                              }, (r) {
                                setState(() {
                                  widget.invite =
                                      widget.invite.copyWith(status: 'Revoked');
                                });
                                context.snackBarSuccess('Invite revoked');
                              });
                              context.read<EESUpoolRepository>();
                              context.loaderOverlay.show();
                              await repo.deleteInviteOrRequest(
                                  widget.invite.userId,
                                  widget.invite.eesupoolId);
                              context.loaderOverlay.hide();

                              result.fold((l) {
                                context.snackBarError(
                                    'Failed to revoke the invite');
                              }, (r) {
                                context.snackBarSuccess('Invite revoked');
                              });
                              setState(() {
                                accepting = false;
                              });
                            },
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.close,
                                  size: 17,
                                  color: Colors.redAccent,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Revoke",
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            if (widget.invite.status == 'Accepted')
              const Text(
                "Accepted",
                style: TextStyle(color: Colors.green),
              ),
            if (widget.invite.status == 'Declined')
              const Text(
                "Rejected",
                style: TextStyle(color: Colors.redAccent),
              ),
          ],
        ),
      ),
    );
  }
}
