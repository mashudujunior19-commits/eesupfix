import 'package:auto_route/auto_route.dart';
import 'package:data/partners/models/partner.dart';
import 'package:data/partners/models/partner_application.dart';
import 'package:data/partners/repository/partner_repository.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/features/partners/bloc/applications_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:data/utils/eesup_exception.dart';

@RoutePage()
class PartnerAppScreen extends StatelessWidget {
  const PartnerAppScreen({super.key, required this.partner});
  final Partner partner;

  //Helpler to keep track of the current number of apps
  // int _currentAppsCount = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApplicationsBloc(context.read<PartnerRepository>())
        ..add(ApplicationsFetched(partner.id)),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: Text(partner.title),
            actions: [
              IconButton(
                onPressed: () async {
                  // if (_currentAppsCount == partner.maxApps) {
                  //   context.snackBarError(
                  //     'You can only apply for ${partner.maxApps} applications at a time.',
                  //   );
                  //   return;
                  // }

                  // if (context.loaderOverlay.visible) return;

                  // context.loaderOverlay.show();
                  // final result = await ref
                  //     .read(partnerRepoProvider)
                  //     .createPartnerApplications(partner.id);
                  // if (context.mounted) {
                  //   context.loaderOverlay.hide();
                  // }

                  // result.fold(
                  //   (l) {
                  //     context.snackBarError(l.message);
                  //   },
                  //   (r) {
                  //     if (r == 0) {
                  //       context.snackBarError(
                  //         'Your current account type is not allowed to create an'
                  //         ' application for this Service. for more information, refer to EESUp\'s'
                  //         'Youtube channel or contact support.',
                  //       );
                  //       return;
                  //     }

                  //     if (r == 1) {
                  //       context.snackBarError(
                  //         'Failed to create an appplication. if this error'
                  //         ' persists, please contact support.',
                  //       );
                  //       return;
                  //     }

                  //     ref.invalidate(_partnersAppsProvider(partner.id));
                  //     context.snackBarSuccess(
                  //       'Applcation started, complete the questioneers.',
                  //     );
                  //   },
                  // );
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          body: Container(
            decoration: context.bgImage,
            height: double.infinity,
            width: double.infinity,
            child: BlocBuilder<ApplicationsBloc, ApplicationsState>(
              builder: (context, state) {
                if (state is ApplicationsLoaded) {
                  final apps = state.applications;
                  return ListView.builder(
                    itemCount: apps.length,
                    itemBuilder: (context, index) {
                      final app = apps[index];
                      return _ApplicationCard(app: app, partner: partner)
                          .animate()
                          .slideIn(index * 50);
                    },
                  );
                } else if (state is ApplicationsLoading) {
                  return const FullScreenLoadingShimmer();
                } else if (state is ApplicationsError) {
                  return FullScreenError(exception: state.exception);
                } else {
                  return FullScreenError(
                    exception: EESUpException(message: ''),
                    isError: false,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ApplicationCard extends StatelessWidget {
  const _ApplicationCard({required this.app, required this.partner});
  final PartnerApplication app;
  final Partner partner;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return InkWell(
      onTap: () {
        // context.push(
        //   EditApplication.route,
        //   extra: (app: app, partner: partner),
        // );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15, right: 20, left: 20),
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.shade300,
            width: .5,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: CircleAvatar(
            backgroundColor: colorScheme.primary.withOpacity(.1),
            child: Icon(
              IconlyLight.work,
              color: colorScheme.primary,
            ),
          ),
          title: Text('REF-${app.id}'),
          subtitle: Text(
            app.approvedAt != null ? 'Approved' : 'Pending',
            style: textTheme.labelSmall?.copyWith(
              color: app.approvedAt != null
                  ? colorScheme.primary
                  : colorScheme.error,
            ),
          ),
          trailing: Icon(
            IconlyLight.arrowRight2,
            color: colorScheme.primary,
            size: 17,
          ),
        ),
      ),
    );
  }
}
