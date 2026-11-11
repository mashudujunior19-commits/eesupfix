import 'package:data/auth/models/profile.dart';
import 'package:data/get_involved/models/business_profile.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';

/// The business details shown while the Business profile is active. It is
/// view-only: nothing here can be edited, and none of the person's own
/// details (name, ID number, email, phone) appear on it.
class BusinessProfileScreen extends StatelessWidget {
  const BusinessProfileScreen({
    super.key,
    required this.profile,
    required this.business,
  });

  final Profile profile;
  final BusinessProfile? business;

  static String? _clean(String? value) {
    final v = value?.trim();
    return (v == null || v.isEmpty) ? null : v;
  }

  @override
  Widget build(BuildContext context) {
    final name = _clean(business?.businessName) ??
        _clean(profile.corpName) ??
        'My business';
    final registration =
        _clean(business?.registrationNumber) ?? _clean(profile.corpReg);
    final vat = _clean(business?.vatNumber) ?? _clean(profile.corpVatNo);

    final rows = <_Detail>[
      _Detail('Company name', name),
      _Detail('Registration number', registration ?? 'Not provided'),
      if (vat != null) _Detail('VAT number', vat),
      if (_clean(business?.taxNumber) != null)
        _Detail('Tax number', business!.taxNumber!.trim()),
      if (_clean(business?.businessType) != null)
        _Detail('Business type', business!.businessType!.trim()),
      if (_clean(business?.industryType) != null)
        _Detail('Industry', business!.industryType!.trim()),
      if (_clean(business?.address) != null)
        _Detail('Business address', business!.address!.trim()),
      if (_clean(business?.province) != null)
        _Detail('Province', business!.province!.trim()),
      if (business?.referralCode != null)
        _Detail('Business referral code', '${business!.referralCode}'),
      const _Detail('Profile type', 'Business (Corporate)'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Business profile')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: CircleAvatar(
                radius: 36,
                backgroundColor: context.colorScheme.primary.withOpacity(.12),
                child: Icon(
                  MdiIcons.officeBuildingOutline,
                  size: 34,
                  color: context.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: context.textTheme.labelMedium
                    ?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 20),
            for (final row in rows) _DetailTile(detail: row),
            const SizedBox(height: 12),
            Text(
              'These details are view-only. To change them, contact support.',
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _Detail {
  const _Detail(this.label, this.value);
  final String label;
  final String value;
}

class _DetailTile extends StatelessWidget {
  const _DetailTile({required this.detail});
  final _Detail detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: .5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(detail.label, style: context.textTheme.labelSmall),
          const SizedBox(height: 2),
          SelectableText(
            detail.value,
            style: context.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
