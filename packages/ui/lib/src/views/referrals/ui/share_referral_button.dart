import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/auth/repository/profile_repository.dart';
import 'package:data/auth/repository/referrals_repository.dart';
import 'package:data/referrals/data_source/referrals_supabase_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:share_plus/share_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';

/// Opens the share sheet with the user's referral link and code, so they
/// can send it over WhatsApp, SMS, email, etc.
Future<void> shareReferralLink(BuildContext context, {int? code}) async {
  final referralCode = code ??
      (await context.read<ProfileRepository>().fetchSessionProfile())
          .fold((l) => null, (r) => r?.referralCode);
  if (!context.mounted) return;
  if (referralCode == null) {
    context.snackBarError('Your referral code isn\'t available yet.');
    return;
  }

  final repo = ReferralsRepository(
    context.read<AuthRepository>(),
    ReferralsSupabaseImpl(GetIt.I.get<SupabaseClient>()),
  );
  final link = await repo.referralLink(referralCode);
  if (!context.mounted) return;

  final box = context.findRenderObject() as RenderBox?;
  await SharePlus.instance.share(
    ShareParams(
      text: link.message,
      subject: 'Join me on EESUp',
      // Needed on iPad, where the share sheet is a popover.
      sharePositionOrigin:
          box == null ? null : box.localToGlobal(Offset.zero) & box.size,
    ),
  );
}

class ShareReferralButton extends StatelessWidget {
  const ShareReferralButton({super.key, this.code, this.color});

  final int? code;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Share referral link',
      onPressed: () => shareReferralLink(context, code: code),
      icon: Icon(Icons.share_outlined, color: color, size: 20),
    );
  }
}
