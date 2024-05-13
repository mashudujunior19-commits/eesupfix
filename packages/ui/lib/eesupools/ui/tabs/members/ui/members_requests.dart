import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/eesupools/models/eesupool_request.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:ui/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:ui/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/eesupools/ui/tabs/members/bloc/members_invites_bloc.dart';
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

class _InviteCard extends StatelessWidget {
  const _InviteCard({required this.invite, required this.pool});
  final EESUpoolRequest invite;
  final EESUpool pool;

  @override
  Widget build(BuildContext context) {
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
          child: Text(invite.fullName?.substring(0, 1) ?? '~'),
        ),
        title: Text(invite.fullName ?? invite.corporateName ?? '~'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  invite.role.toString(),
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
                    invite.status,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 9,
                    ),
                  ),
                ),
              ],
            ),
            if (invite.status == 'Pending')
              if (pool.role == EESUpoolMemberRole.admin)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    InkWell(
                      onTap: () async {
                        // final id = pool.eesupoolId;

                        // if (id == null) return;
                        // ref
                        //     .read(loadingStateProvider.notifier)
                        //     .toggle();
                        // final result = await ref
                        //     .read(eesupoolRepoProvider)
                        //     .deleteInviteOrRequest(
                        //         invite.userId, id);
                        // ref
                        //     .read(loadingStateProvider.notifier)
                        //     .toggle();

                        // result.fold((l) {
                        //   showSnackBar(
                        //     context: context,
                        //     type: SnackBarType.error,
                        //     message: l.message,
                        //   );
                        // }, (r) {
                        //   ref.invalidate(
                        //       _eesupoolInvitesProvider(id));
                        //   showSnackBar(
                        //     context: context,
                        //     type: SnackBarType.success,
                        //     message:
                        //         'Invitation revoked for ${invite.fullName}',
                        //   );
                        // });
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
          ],
        ),
      ),
    );
  }
}
