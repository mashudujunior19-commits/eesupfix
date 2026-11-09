import 'package:auto_route/auto_route.dart';
import 'package:data/auth/repository/profile_repository.dart';
import 'package:data/get_involved/models/get_involved_submission.dart';
import 'package:data/get_involved/repository/get_involved_repository.dart';
import 'package:data/notifications/models/notification.dart' as not;
import 'package:data/notifications/models/notification_data.dart';
import 'package:data/partners/models/partner.dart';
import 'package:data/partners/repository/partner_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/widgets/back_to_home_button.dart';

/// Get Involved and partner (Kasipreneur, KasiSpaza, Vendor) application
/// notifications carry the id of the application they are about.
bool isApplicationNotification(NotificationData? data) =>
    data != null &&
    (data.kind == 'get_involved' || data.kind == 'partner_application');

/// Opens the current status of the application a notification is about. The
/// status is read live, so it always matches what the reviewer sees.
Future<void> openApplicationStatus(
  BuildContext context,
  not.Notification notification,
) async {
  final data = notification.data;
  if (data == null) return;

  if (data.kind == 'partner_application') {
    await _openPartnerStatus(context, data);
  } else {
    await _showGetInvolvedStatus(context, data);
  }
}

Future<void> _openPartnerStatus(
  BuildContext context,
  NotificationData data,
) async {
  final router = context.router;
  final profiles = context.read<ProfileRepository>();
  final partners = context.read<PartnerRepository>();

  final profile = (await profiles.fetchSessionProfile()).fold((l) => null, (r) => r);
  if (profile == null || !context.mounted) return;
  final list = (await partners.fetchPartnerships(profile.role)).fold(
    (l) => <Partner>[],
    (r) => r,
  );
  if (!context.mounted) return;
  final partner = list.where((p) => p.id == data.partnerId);
  if (partner.isEmpty) {
    context.snackBarError('This application is not available right now.');
    return;
  }
  router.push(PartnerAppRoute(partner: partner.first));
}

Future<void> _showGetInvolvedStatus(
  BuildContext context,
  NotificationData data,
) async {
  final repo = context.read<GetInvolvedRepository>();

  final result = await repo.fetchMySubmissions();
  if (!context.mounted) return;
  final submissions = result.fold((l) => <GetInvolvedSubmission>[], (r) => r);
  final matches = submissions.where((s) => s.id == data.submissionId);
  if (matches.isEmpty) {
    context.snackBarError(
      result.isLeft
          ? 'Something went wrong, please try again.'
          : 'We could not find this application.',
    );
    return;
  }
  final s = matches.first;
  final status = s.status ?? 'pending';

  await showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(s.organisationName),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _label(status),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _color(status),
            ),
          ),
          const SizedBox(height: 8),
          if (status == 'pending')
            const Text('Your application is being reviewed.'),
          if (status == 'approved')
            const Text('Approved. You can now switch to your business '
                'profile from Menu › Switch Profile.'),
          if (status == 'rejected' && (s.decisionReason ?? '').isNotEmpty)
            Text('Reason: ${s.decisionReason}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(ctx).pop();
            goToHome(context);
          },
          child: const Text('Back to Home'),
        ),
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}

String _label(String status) => switch (status) {
      'approved' => 'Approved',
      'rejected' => 'Declined',
      _ => 'Pending',
    };

Color _color(String status) => switch (status) {
      'approved' => Colors.green,
      'rejected' => Colors.red,
      _ => Colors.orange,
    };
