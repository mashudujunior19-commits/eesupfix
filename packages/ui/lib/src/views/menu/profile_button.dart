import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/auth/models/profile.dart';
import 'package:data/auth/models/user_role.dart';
import 'package:data/get_involved/models/business_profile.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/views/menu/business_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({
    super.key,
    required this.profile,
    required this.onPop,
    this.business,
    this.businessMode = false,
  });
  final Profile profile;

  /// True while the Business profile is active. Nothing personal (name,
  /// verification badge, personal referral code) is shown then, and the
  /// profile opens read-only.
  final bool businessMode;

  /// The business details loaded for the Business profile: its name, referral
  /// code and registration details are shown instead of the person's own.
  final BusinessProfile? business;
  final VoidCallback onPop;

  String get _displayName {
    if (businessMode) {
      final name = business?.businessName ?? '';
      if (name.isNotEmpty) return name;
      final corp = profile.corpName ?? '';
      return corp.isNotEmpty ? corp : 'My business';
    }
    return profile.firstName != null
        ? '${profile.firstName} ${profile.lastName}'
        : profile.corpName ?? '';
  }

  String? get _registration {
    if (!businessMode) return null;
    final reg = business?.registrationNumber ?? '';
    if (reg.isNotEmpty) return reg;
    final corp = profile.corpReg ?? '';
    return corp.isNotEmpty ? corp : null;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        if (businessMode) {
          // The business profile is view-only: nothing on it can be edited.
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => BusinessProfileScreen(
                profile: profile,
                business: business,
              ),
            ),
          );
          return;
        }
        context.router
            .push(EditProfileRoute(profile: profile))
            .whenComplete(() {
          onPop.call();
        });
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15, right: 20, left: 20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300, width: .5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: context.colorScheme.primary.withOpacity(.2),
                  child: Icon(
                    [
                      UserRole.EESUpliftCorporate,
                      UserRole.Corporate,
                      UserRole.Admin,
                    ].contains(profile.role)
                        ? MdiIcons.officeBuildingOutline
                        : IconlyBold.profile,
                    size: 24,
                    color: context.colorScheme.primary.withOpacity(.6),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            _displayName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.labelMedium?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (profile.isVerified && !businessMode)
                          const Padding(
                            padding: EdgeInsets.only(
                              top: 2,
                              left: 5,
                              bottom: 5,
                            ),
                            child: Icon(
                              BootstrapIcons.patch_check_fill,
                              size: 18,
                              color: Colors.blue,
                            ),
                          ),
                      ],
                    ),
                    if (profile.role == UserRole.Corporate)
                      Container(
                        margin: const EdgeInsets.only(top: 3),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: context.colorScheme.primary.withOpacity(.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Corporate',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    if (_registration != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text('Reg. no. $_registration',
                            style: context.textTheme.labelSmall),
                      ),
                    if (businessMode
                        ? business?.referralCode != null
                        : profile.role != UserRole.Corporate)
                      Row(
                        children: [
                          Text('Referral code',
                              style: context.textTheme.labelSmall),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 1),
                            decoration: BoxDecoration(
                              color:
                                  context.colorScheme.primary.withOpacity(.9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              (businessMode
                                      ? business?.referralCode
                                      : profile.referralCode)
                                  .toString(),
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                )),
              ],
            )),
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(IconlyLight.arrowRight2, size: 17),
            )
          ],
        ),
      ),
    );
  }
}
