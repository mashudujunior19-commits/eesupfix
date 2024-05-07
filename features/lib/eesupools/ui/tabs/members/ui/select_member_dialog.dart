import 'package:data_sources/eesupools/models/eesupool.dart';
import 'package:features/core/widgets/fullscreen_error_widget.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:features/eesupools/ui/tabs/members/bloc/members_bloc.dart';
import 'package:features/eesupools/ui/tabs/members/ui/member_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:repository/eesupools/eesupool_repo.dart';
import 'package:repository/utils/eesup_exception.dart';

class SelectMemberDialog extends StatelessWidget {
  const SelectMemberDialog({super.key, required this.pool});
  final EESUpool pool;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Select member'),
      ),
      body: BlocProvider(
        create: (context) => MembersBloc(context.read<EESUpoolRepository>())
          ..add(MembersFetched(pool.eesupoolId!, 50)),
        child: BlocBuilder<MembersBloc, MembersState>(
          builder: (context, state) {
            if (state is MembersLoading) {
              return const FullScreenLoadingShimmer();
            } else if (state is MembersLoaded) {
              return ListView.builder(
                itemCount: state.members.length,
                itemBuilder: (context, index) {
                  return MemberCard(
                    member: state.members[index],
                    pool: pool,
                    onTap: () {
                      Navigator.of(context).pop(state.members[index]);
                    },
                  ).animate().slideIn((50 * index).toDouble());
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
      ),
    );
  }
}
