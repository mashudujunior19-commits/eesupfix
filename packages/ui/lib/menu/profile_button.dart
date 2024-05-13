import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/auth/models/profile.dart';
import 'package:data/auth/models/user_role.dart';
import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:ui/app_route.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key, required this.profile});
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () async {
        context.router.push(EditProfileRoute(profile: profile));
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
            Row(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          profile.firstName != null
                              ? '${profile.firstName} ${profile.lastName}'
                              : profile.corpName ?? '',
                          style: context.textTheme.labelMedium?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (profile.isVerified)
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
                    if (profile.role != UserRole.Corporate)
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
                              profile.referralCode.toString(),
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                )
              ],
            ),
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
