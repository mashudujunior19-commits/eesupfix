// ignore_for_file: unused_element
import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/auth/repository/profile_repository.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import 'package:ui/src/views/auth/profile/bloc/profile_bloc.dart';
import 'package:ui/src/views/auth/sign_in/bloc/auth_bloc.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/views/menu/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:package_info_plus/package_info_plus.dart';

final shorebirdCodePush = ShorebirdCodePush();

class MenuTab extends StatefulWidget {
  const MenuTab({super.key});

  @override
  State<MenuTab> createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> {
  String appVersion = '';

  @override
  void initState() {
    super.initState();
    _getAppVersion();
  }

  // Function to fetch app version
  Future<void> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: ProfileBloc(context.read<ProfileRepository>())
        ..add(ProfileFetched()),
      builder: (context, state) {
        if (state is ProfileLoaded) {
          print(state);
          final profile = state.profile;
          return Column(
            children: [
              Builder(builder: (context) {
                return EditProfileButton(
                  profile: profile,
                  onPop: () {
                    context.read<ProfileBloc>().add(ProfileFetched());
                    setState(() {});
                  },
                );
              }),
              Container(
                margin: const EdgeInsets.only(top: 25, right: 20, left: 20),
                padding: const EdgeInsets.all(10),
                width: context.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: GridView(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  children: [
                    _MenuButton(
                      label: 'My Addresses',
                      icon: IconlyLight.location,
                      onTap: () {
                        context.router
                            .push(const AddressBookRoute())
                            .then((value) => null);
                      },
                    ),
                    _MenuButton(
                      label: 'MyBaskets',
                      icon: BootstrapIcons.basket,
                      onTap: () {
                        context.router.push(const BasketsListRoute());
                      },
                    ),
                    _MenuButton(
                      label: 'Surveys',
                      icon: IconlyLight.chart,
                      onTap: () {
                        context.router.push(const SurveyRoute());
                      },
                    ),
                    _MenuButton(
                      label: 'Get Involved',
                      icon: IconlyLight.work,
                      onTap: () {
                        context.router.push(PartnerRoute(role: profile.role));
                      },
                    ),
                    _MenuButton(
                      label: 'Request Products',
                      icon: IconlyLight.plus,
                      onTap: () {
                        context.router.push(const ProductRequestRoute());
                      },
                    ),
                    _MenuButton(
                      label: 'Hampers',
                      icon: BootstrapIcons.basket2,
                      onTap: () {
                        context.router.push(const HampersList());
                      },
                    ),
                    // _MenuButton(
                    //   isVisible: false,
                    //   label: 'Support',
                    //   icon: IconlyLight.user3,
                    //   onTap: () {},
                    // ),
                    _MenuButton(
                      label: 'Legal',
                      icon: IconlyLight.document,
                      onTap: () {
                        context.router.push(const TermsOfServiceRoute());
                      },
                    ),
                  ],
                ),
              ),
              _MenuButtonTile(
                showBorder: false,
                icon: IconlyLight.logout,
                label: 'Sign Out',
                onTap: () {
                  context.read<AuthBloc>().add(SignOutPressed());
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'App Version: $appVersion',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
              // FutureBuilder(
              //     future: shorebirdCodePush.currentPatchNumber(),
              //     builder: (context, snap) {
              //       if (snap.hasData) {
              //         return Text(snap.data.toString());
              //       } else {
              //         return const SizedBox.shrink();
              //       }
              //     })
            ],
          );
        } else if (state is ProfileLoading) {
          return const FullScreenLoadingShimmer();
        } else if (state is ProfileError) {
          return FullScreenError(exception: state.ex);
        } else {
          return FullScreenError(
            exception: EESUpException(
              message: 'Something went wrong while '
                  'trying to fetch the available Services.',
            ),
          );
        }
      },
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({
    this.isVisible = true,
    required this.label,
    required this.icon,
    required this.onTap,
  });
  final bool isVisible;
  final String label;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 100,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.shade300,
            width: .5,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              10.sH,
              Icon(icon, size: 32),
              5.sH,
              Expanded(
                child: Text(
                  label,
                  style: textTheme.labelMedium?.copyWith(fontSize: 9.5),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuButtonTile extends StatelessWidget {
  const _MenuButtonTile({
    super.key,
    required this.label,
    this.icon,
    required this.onTap,
    this.counter,
    this.isVisible = true,
    this.showBorder = true,
    this.imagePath,
    this.size,
  });
  final String? imagePath;
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final int? counter;
  final bool isVisible;
  final bool showBorder;
  final double? size;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(top: 25, right: 20, left: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.shade300,
            width: .5,
          ),
        ),
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(
          children: [
            if (imagePath != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Image.asset(
                  imagePath!,
                  width: size ?? 22,
                  height: size ?? 21,
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Icon(
                  icon,
                  color: Colors.black,
                  size: 22,
                ),
              ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 15),
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                decoration: showBorder
                    ? BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: colorScheme.secondary,
                            width: .1,
                          ),
                        ),
                      )
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      style: textTheme.labelSmall?.copyWith(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    const Icon(IconlyLight.arrowRight2, size: 17)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
