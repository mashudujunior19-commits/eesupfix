import 'package:data/organisation/models/organisation_registration_status.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/views/organisation/cubit/organisation_cubit.dart';
import 'package:ui/src/views/organisation/cubit/organisation_form.dart';
import 'package:ui/src/views/organisation/ui/widgets/organisation_option_tile.dart';

class RegistrationStatusStep extends StatelessWidget {
  const RegistrationStatusStep({
    super.key,
    required this.form,
    required this.tabController,
  });

  final OrganisationForm form;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      children: [
        Text(
          'Is the organisation registered or unregistered?',
          style: context.textTheme.labelMedium?.copyWith(fontSize: 18),
        ).animate().slideIn(0),
        25.sH,
        OrganisationOptionTile(
          title: 'Registered',
          subtitle: 'The organisation has a formal registration number.',
          isSelected:
              form.registrationStatus ==
                  OrganisationRegistrationStatus.registered,
          onTap: () =>
              _select(context, OrganisationRegistrationStatus.registered),
        ).animate().slideIn(50),
        15.sH,
        OrganisationOptionTile(
          title: 'Unregistered',
          subtitle: 'The organisation is not yet formally registered.',
          isSelected:
              form.registrationStatus ==
                  OrganisationRegistrationStatus.unregistered,
          onTap: () =>
              _select(context, OrganisationRegistrationStatus.unregistered),
        ).animate().slideIn(100),
      ],
    );
  }

  void _select(BuildContext context, OrganisationRegistrationStatus status) {
    context.read<OrganisationCubit>().updateForm(
          form.copyWith(registrationStatus: status),
        );
    tabController.animateTo(tabController.index + 1);
  }
}
