import 'package:auto_route/auto_route.dart';
import 'package:data/get_involved/repository/get_involved_repository.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ui/src/core/widgets/eesup_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/views/organisation/cubit/organisation_cubit.dart';
import 'package:ui/src/views/organisation/cubit/organisation_form.dart';
import 'package:ui/src/views/organisation/ui/org_type_step.dart';
import 'package:ui/src/views/organisation/ui/organisation_details_form.dart';
import 'package:ui/src/views/organisation/ui/organisation_success_screen.dart';
import 'package:ui/src/views/organisation/ui/registration_status_step.dart';

/// Multi-step "Register an Organisation" wizard.
///
/// This route assumes the caller has already enforced the verification gate
/// (only a verified, Individual profile should be able to reach it) --
/// consistent with how the rest of the app gates access (see the "Get
/// Involved" entry in the menu) rather than with a dedicated route guard.
@RoutePage()
class OrganisationRegistrationScreen extends StatefulWidget {
  const OrganisationRegistrationScreen({super.key});

  @override
  State<OrganisationRegistrationScreen> createState() =>
      _OrganisationRegistrationScreenState();
}

class _OrganisationRegistrationScreenState
    extends State<OrganisationRegistrationScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  static const int _lastTabIndex = 3;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrganisationCubit(context.read<GetInvolvedRepository>()),
      child: BlocConsumer<OrganisationCubit, OrganisationForm>(
        listener: (context, state) {
          if (state.isLoading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
        },
        builder: (context, state) {
          return EESUpScaffold(
            body: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: _tabController.index != _lastTabIndex
                    ? BackButton(onPressed: () {
                        if (_tabController.index == 0) {
                          Navigator.of(context).pop();
                        } else {
                          _tabController.animateTo(_tabController.index - 1);
                        }
                      })
                    : null,
                title: _tabController.index != _lastTabIndex
                    ? const Text('Register an Organisation')
                    : null,
              ),
              body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  OrgTypeStep(form: state, tabController: _tabController),
                  RegistrationStatusStep(
                    form: state,
                    tabController: _tabController,
                  ),
                  OrganisationDetailsForm(
                    form: state,
                    tabController: _tabController,
                  ),
                  const OrganisationSuccessScreen(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
