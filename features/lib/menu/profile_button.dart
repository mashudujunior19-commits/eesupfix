import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data_sources/auth/models/user_role.dart';
import 'package:features/auth/profile/bloc/profile_bloc.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/navigation/app_route.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:repository/auth/profile_repository.dart';
import 'package:shimmer/shimmer.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      bloc: ProfileBloc(context.read<ProfileRepository>())
        ..add(ProfileFetched()),
      listener: (context, state) {
        if (state is ProfileLoading) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
        }
      },
      builder: (context, state) {
        if (state is ProfileLoaded) {
          final profile = state.profile;
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
                        backgroundColor:
                            context.colorScheme.primary.withOpacity(.2),
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
                                    color: context.colorScheme.primary
                                        .withOpacity(.9),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    profile.referralCode.toString(),
                                    style:
                                        context.textTheme.bodyMedium?.copyWith(
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
        } else {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade50,
            child: Container(
              height: 70,
              margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
              width: context.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
      },
    );
  }
}
