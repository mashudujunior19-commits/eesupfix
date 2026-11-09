import 'package:auto_route/auto_route.dart';
import 'package:data/auth/models/user_role.dart';
import 'package:data/partners/models/partner.dart';
import 'package:data/partners/repository/partner_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';

/// Partner ids as the database knows them. The application type stays distinct
/// per programme, so the admin app's filters and notifications stay correct
/// wherever the entry point lives.
abstract final class PartnerIds {
  static const kasipreneur = 'eesupreneur';
  static const kasiSpaza = 'kasi_spaza';
  static const vendor = 'service_listing';
}

/// Opens one programme's own application screen after checking the applicant
/// is eligible. KasiPreneur needs a public KasiPool of 25+ members; Kasi Spaza
/// needs an existing KasiPreneur. The database enforces both as well.
Future<void> openPartnerApplication(
  BuildContext context,
  Partner partner,
) async {
  final router = context.router;
  final repo = context.read<PartnerRepository>();
  final check = await repo.fetchEligibility(partner.id);
  if (!context.mounted) return;
  final eligibility = check.fold((l) => null, (r) => r);
  if (eligibility != null && !eligibility.eligible) {
    context.snackBarError(
      eligibility.reason ?? 'You are not eligible to apply for this.',
    );
    return;
  }
  router.push(PartnerAppRoute(partner: partner));
}

/// Finds a programme by id and opens its application screen directly, so each
/// Get Involved list item goes to its own form.
Future<void> startPartnerApplication(
  BuildContext context, {
  required String partnerId,
  required UserRole role,
}) async {
  final repo = context.read<PartnerRepository>();
  final result = await repo.fetchPartnerships(role);
  if (!context.mounted) return;
  final partners = result.fold((l) => <Partner>[], (r) => r);
  final matches = partners.where((p) => p.id == partnerId);
  if (matches.isEmpty) {
    context.snackBarError(
      result.isLeft
          ? 'Something went wrong, please try again.'
          : 'This application is not available to your account right now.',
    );
    return;
  }
  await openPartnerApplication(context, matches.first);
}
