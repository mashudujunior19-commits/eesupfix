import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/auth/models/user_role.dart';
import 'package:data/get_involved/repository/get_involved_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/views/partners/ui/start_partner_application.dart';

/// The exact text shown when someone who is not a KasiLift Organisation tries
/// to become a Kasipromoter. The server returns the same text.
const kasipromoterBlockedMessage =
    'You cannot be a Kasipromoter. Only a Kasilift Organisation can refer and '
    'become a Kasipromoter.';

/// Shown when a verified Individual or a Corporate account taps "Get Involved"
/// from the menu. Every programme lives here and each item opens its own
/// application: Kasipreneur and Kasi Spaza are no longer listed under Become a
/// Vendor.
///
/// [hostContext] is the screen that opened the sheet. The sheet closes itself
/// before an action runs, so the action (navigation, messages) needs a context
/// that is still alive afterwards.
class GetInvolvedSheet extends StatelessWidget {
  const GetInvolvedSheet({
    super.key,
    required this.role,
    required this.hostContext,
  });

  final UserRole role;
  final BuildContext hostContext;

  void _close(BuildContext context) => Navigator.of(context).pop();

  Future<void> _becomeKasipromoter() async {
    final repo = hostContext.read<GetInvolvedRepository>();
    final result = await repo.becomeKasipromoter();
    if (!hostContext.mounted) return;
    result.fold(
      (error) => hostContext.snackBarError(error.message),
      (r) => r.ok
          ? hostContext.snackBarSuccess('You are now a Kasipromoter.')
          : hostContext.snackBarError(r.message ?? kasipromoterBlockedMessage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      shrinkWrap: true,
      children: [
        Row(
          children: [
            IconButton(
              tooltip: 'Back',
              icon: const Icon(Icons.arrow_back),
              onPressed: () => _close(context),
            ),
            const SizedBox(width: 4),
            Text(
              'Get Involved',
              style: context.textTheme.labelMedium?.copyWith(fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 15),
        _GetInvolvedOption(
          icon: IconlyLight.work,
          title: 'Register a business / Non-profit company / '
              'Unregistered voluntary association',
          subtitle: 'Register a business or an NPO/Voluntary Association.',
          onTap: () {
            _close(context);
            hostContext.router.push(const OrganisationRegistrationRoute());
          },
        ),
        _GetInvolvedOption(
          icon: BootstrapIcons.shop,
          title: 'Kasipreneur',
          subtitle: 'Apply to become a KasiPreneur.',
          onTap: () {
            _close(context);
            startPartnerApplication(
              hostContext,
              partnerId: PartnerIds.kasipreneur,
              role: role,
            );
          },
        ),
        _GetInvolvedOption(
          icon: BootstrapIcons.basket,
          title: 'KasiSpaza',
          subtitle: 'Apply to open a KasiSpaza.',
          onTap: () {
            _close(context);
            startPartnerApplication(
              hostContext,
              partnerId: PartnerIds.kasiSpaza,
              role: role,
            );
          },
        ),
        _GetInvolvedOption(
          icon: BootstrapIcons.people,
          title: 'Become a Vendor',
          subtitle: 'Apply to have your service or product listed.',
          onTap: () {
            _close(context);
            startPartnerApplication(
              hostContext,
              partnerId: PartnerIds.vendor,
              role: role,
            );
          },
        ),
        _GetInvolvedOption(
          icon: BootstrapIcons.arrow_up_circle,
          title: 'Upgrade to KasiLift Organisation',
          subtitle: 'Already registered? Opt an existing registration into '
              'the Social Wallet funding ecosystem.',
          onTap: () {
            _close(context);
            hostContext.router.push(const KasiliftUpgradeRoute());
          },
        ),
        _GetInvolvedOption(
          icon: BootstrapIcons.megaphone,
          title: 'Become a Kasipromoter',
          subtitle: 'Only KasiLift Organisations can refer and become '
              'Kasipromoters.',
          onTap: () {
            _close(context);
            _becomeKasipromoter();
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
