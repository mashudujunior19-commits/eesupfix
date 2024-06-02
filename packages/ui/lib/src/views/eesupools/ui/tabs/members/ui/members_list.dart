import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/views/eesupools/ui/tabs/members/bloc/members_bloc.dart';
import 'package:ui/src/views/eesupools/ui/tabs/members/ui/invite_members_dialog.dart';
import 'package:ui/src/views/eesupools/ui/tabs/members/ui/member_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data/utils/eesup_exception.dart';

class MembersListView extends StatelessWidget {
  const MembersListView({super.key, required this.pool});
  final EESUpool pool;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MembersBloc(context.read<EESUpoolRepository>())
        ..add(MembersFetched(pool.eesupoolId!, 50)),
      child: BlocBuilder<MembersBloc, MembersState>(
        builder: (context, state) {
          if (state is MembersLoading) {
            return const FullScreenLoadingShimmer();
          } else if (state is MembersLoaded) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              floatingActionButton: pool.role == EESUpoolMemberRole.admin
                  ? FloatingActionButton.small(
                      backgroundColor: context.colorScheme.primary,
                      child: const Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        context.showBottomSheetDialog(
                          child: InviteMembersDialog(
                            poolId: pool.eesupoolId!,
                            isNewPool: false,
                          ),
                        );
                      },
                    )
                  : null,
              body: ListView.builder(
                itemCount: state.members.length,
                itemBuilder: (context, index) {
                  return MemberCard(
                    member: state.members[index],
                    pool: pool,
                  ).animate().slideIn((50 * index).toDouble());
                },
              ),
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
