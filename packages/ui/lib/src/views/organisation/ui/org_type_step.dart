import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/views/organisation/cubit/organisation_cubit.dart';
import 'package:ui/src/views/organisation/cubit/organisation_form.dart';
import 'package:ui/src/views/organisation/ui/widgets/organisation_option_tile.dart';

class OrgTypeStep extends StatelessWidget {
  const OrgTypeStep({
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
          'What type of organisation are you registering?',
          style: context.textTheme.labelMedium?.copyWith(fontSize: 18),
        ).animate().slideIn(0),
        25.sH,
        OrganisationOptionTile(
          title: 'Public Benefit (NPO)',
          subtitle: 'A non-profit organisation serving a public benefit.',
          isSelected: form.orgKind == OrganisationKind.publicBenefit,
          onTap: () => _select(context, OrganisationKind.publicBenefit),
        ).animate().slideIn(50),
        15.sH,
        OrganisationOptionTile(
          title: 'Business (For-Profit)',
          subtitle: 'A commercial, for-profit business.',
          isSelected: form.orgKind == OrganisationKind.business,
          onTap: () => _select(context, OrganisationKind.business),
        ).animate().slideIn(100),
      ],
    );
  }

  void _select(BuildContext context, OrganisationKind kind) {
    context.read<OrganisationCubit>().updateForm(
          form.copyWith(orgKind: kind),
        );
    tabController.animateTo(tabController.index + 1);
  }
}
