import 'package:auto_route/auto_route.dart';
import 'package:data/partners/models/partner.dart';
import 'package:data/partners/models/partner_application.dart';
import 'package:data/partners/repository/partner_repository.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
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
// ignore: must_be_immutable
class PartnerAppScreen extends StatelessWidget {
  PartnerAppScreen({super.key, required this.partner});
  final Partner partner;

  //Helpler to keep track of the current number of apps
  int _currentAppsCount = 0;

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
              Builder(builder: (context) {
                return IconButton(
                  onPressed: () async {
                    if (_currentAppsCount <= partner.maxApps) {
                      context
                          .read<ApplicationsBloc>()
                          .add(ApplicationCreated(partner.id));
                    } else {
                      context.snackBarError(
                        'You can only have ${partner.maxApps} applications for this service',
                      );
                    }
                  },
                  icon: const Icon(Icons.add),
                );
              }),
            ],
          ),
          body: Container(
            decoration: context.bgImage,
            height: double.infinity,
            width: double.infinity,
            child: BlocConsumer<ApplicationsBloc, ApplicationsState>(
              builder: (context, state) {
                if (state is ApplicationsLoaded) {
                  final apps = state.applications;
                  //UPDATE THE COUNTER, ITS STATE DOES NOT NEED TO BE REFRESHED
                  _currentAppsCount = apps.length;
                  //DISPLAY THE USERS APPLICATIONS
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
              listener: (BuildContext context, ApplicationsState state) {
                if (state is ApplicationCreatedSuccess) {
                  context.read<ApplicationsBloc>().add(
                        ApplicationsFetched(partner.id),
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
        context.router
            .push(
          EditApplicationRoute(
            app: app,
            partner: partner,
          ),
        )
            .whenComplete(() {
          context.read<ApplicationsBloc>().add(
                ApplicationsFetched(partner.id),
              );
        });
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
