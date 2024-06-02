import 'package:auto_route/auto_route.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_issue.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/views/eesupools/ui/tabs/issues/cubit/issues_cubit.dart';

class IssusList extends StatelessWidget {
  const IssusList({super.key, required this.pool});
  final EESUpool pool;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IssuesCubit(
        pool,
        context.read<EESUpoolRepository>(),
      ),
      child: BlocBuilder<IssuesCubit, IssuesState>(
        builder: (context, state) {
          if (state is IssuesLoaded) {
            if (state.issues.isEmpty) {
              return FullScreenError(
                exception: EESUpException(
                  message: 'There are no issues, yet. everything'
                      ' seems to be going well with you community',
                ),
                isError: false,
              );
            }
            return ListView.builder(
              itemCount: state.issues.length,
              itemBuilder: (context, index) {
                final issue = state.issues[index];
                if (issue.resolvedAt == null) {
                  return _IssueCard(pool: pool, issue: issue);
                } else {
                  return const SizedBox();
                }
              },
            );
          } else if (state is IssuesLoading) {
            return const FullScreenLoadingShimmer();
          } else if (state is IssuesError) {
            return FullScreenError(exception: state.err);
          } else {
            return FullScreenError(
              exception: EESUpException(message: ''),
              isError: false,
            );
          }
        },
      ),
    );
  }
}

class _IssueCard extends StatelessWidget {
  const _IssueCard({required this.pool, required this.issue});
  final EESUpool pool;
  final EESUpoolIssue issue;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: context.colorScheme.onSurface.withOpacity(.2),
          width: .5,
        ),
      ),
      child: ListTile(
        onTap: () {
          context.router
              .push(IssueViewRoute(pool: pool, issue: issue))
              .whenComplete(() {});
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        leading: CircleAvatar(
          backgroundColor: context.colorScheme.tertiary.withOpacity(.5),
          child: Text(issue.reporter?.fullName[0] ?? '~'),
        ),
        title: Text(issue.reporter?.fullName ?? '~'),
        subtitle: Text(
          issue.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onSurface.withOpacity(.5),
          ),
        ),
        trailing: Icon(
          IconlyLight.arrowRight2,
          color: context.colorScheme.onSurface.withOpacity(.5),
          size: 20,
        ),
      ),
    );
  }
}
