import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/auth/models/user_role.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

/// Shown when a verified Individual taps "Get Involved" from the menu.
class GetInvolvedSheet extends StatelessWidget {
  const GetInvolvedSheet({super.key, required this.role});

  final UserRole role;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      shrinkWrap: true,
      children: [
        Text(
          'Get Involved',
          style: context.textTheme.labelMedium?.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 15),
        _GetInvolvedOption(
          icon: IconlyLight.work,
          title: 'Register an Organisation',
          subtitle: 'Register a business or public benefit organisation.',
          onTap: () {
            Navigator.of(context).pop();
            context.router.push(const OrganisationRegistrationRoute());
          },
        ),
        _GetInvolvedOption(
          icon: BootstrapIcons.people,
          title: 'Become a Partner',
          subtitle: 'Apply to become one of our partners.',
          onTap: () {
            Navigator.of(context).pop();
            context.router.push(PartnerRoute(role: role));
          },
        ),
        _GetInvolvedOption(
          icon: IconlyLight.paper,
          title: 'Submit an Application',
          subtitle: 'Tell us about your business, registered or not.',
          onTap: () {
            Navigator.of(context).pop();
            context.router.push(const GetInvolvedApplicationRoute());
          },
        ),
      ],
    );
  }
}

class _GetInvolvedOption extends StatelessWidget {
  const _GetInvolvedOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: context.colorScheme.primary),
      title: Text(
        title,
        style: context.textTheme.labelMedium?.copyWith(fontSize: 15),
      ),
      subtitle: Text(
        subtitle,
        style: context.textTheme.bodySmall?.copyWith(
          color: Colors.grey.shade600,
          fontSize: 12.5,
        ),
      ),
    );
  }
}
