// ignore_for_file: unused_element
import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/auth/models/profile.dart';
import 'package:data/auth/models/user_role.dart';
import 'package:data/auth/repository/profile_repository.dart';
import 'package:data/get_involved/models/business_profile.dart';
import 'package:data/get_involved/models/profile_switch_state.dart';
import 'package:data/get_involved/repository/get_involved_repository.dart';
import 'package:ui/src/views/menu/switch_profile_screen.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/views/auth/profile/bloc/profile_bloc.dart';
import 'package:ui/src/views/auth/sign_in/bloc/auth_bloc.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/views/direct_messages/conversations_screen.dart';
import 'package:ui/src/views/direct_messages/dm_review_screen.dart';
import 'package:ui/src/views/menu/get_involved_sheet.dart';
import 'package:ui/src/views/menu/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MenuTab extends StatefulWidget {
  const MenuTab({super.key});

  @override
  State<MenuTab> createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> {
  String appVersion = '';
  ProfileSwitchState? _switchState;
  BusinessProfile? _business;
  // Whose switch state is loaded (or loading), so it is re-read when a
  // different account signs in, and retried if the first read failed.
  String? _switchStateFor;

  @override
  void initState() {
    super.initState();
    _getAppVersion();
    _loadSwitchState();
  }

  Future<void> _loadSwitchState([String? userId]) async {
    _switchStateFor = userId ?? _switchStateFor;
    final result =
        await context.read<GetInvolvedRepository>().profileSwitchState();
    if (!mounted) return;
    final state = result.fold((_) => null, (s) => s);
    if (state == null) {
      _switchStateFor = null; // try again on the next build
      return;
    }
    // The business details are only needed while the Business profile is on.
    BusinessProfile? business;
    if (state.businessActive) {
      business = (await context.read<GetInvolvedRepository>().businessProfile())
          .fold((_) => null, (b) => b);
      if (!mounted) return;
    }
    setState(() {
      _switchState = state;
      _business = business;
    });
  }

  // Function to fetch app version
  Future<void> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
  }

  /// Re-checks verification live (rather than trusting a possibly-stale
  /// cached [Profile]) so a user who has just added their ID/address isn't
  /// stuck seeing an out-of-date "not verified" result, and so the message
  /// names only what's actually still missing.
  Future<void> _onGetInvolvedTapped(BuildContext context, Profile profile) async {
    // Promoters keep access to everything an Individual has. An approved Get
    // Involved application makes the account Corporate; it must still reach this
    // list (a KasiLift Organisation can also become a Kasipreneur and a
    // Kasipromoter).
    if (profile.role != UserRole.Ubuntunist &&
        profile.role != UserRole.EESUpromoter &&
        profile.role != UserRole.Corporate) {
      context.snackBarError('This is only available to Individual accounts.');
      return;
    }

    final profileRepo = context.read<ProfileRepository>();
    final freshProfileResult = await profileRepo.fetchSessionProfile();
    final freshProfile = freshProfileResult.fold((l) => null, (r) => r);
    if (!mounted) return;
    if (freshProfile == null) {
      context.snackBarError('Something went wrong, please try again.');
      return;
    }

    if (freshProfile.isVerified) {
      context.read<ProfileBloc>().add(ProfileReloaded(freshProfile));
      context.showBottomSheetDialog(
        child: GetInvolvedSheet(role: freshProfile.role, hostContext: context),
      );
      return;
    }

    final hasId = freshProfile.rsaIdNumber != null &&
        freshProfile.rsaIdNumber!.trim().isNotEmpty;
    final hasAddressResult = await profileRepo.checkIfHasAddress();
    if (!mounted) return;
    final hasAddress = hasAddressResult.fold((l) => false, (r) => r);

    final missing = <String>[
      if (!hasId) 'your RSA ID',
      if (!hasAddress) 'a primary address',
    ];
    context.snackBarError(
      missing.isEmpty
          ? 'Please complete verification before you can get involved.'
          : 'Please add ${missing.join(' and ')} before you can get involved.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: ProfileBloc(context.read<ProfileRepository>())
        ..add(ProfileFetched()),
      builder: (context, state) {
        if (state is ProfileLoaded) {
          final profile = state.profile;
          if (_switchStateFor != profile.userId) {
            _switchStateFor = profile.userId;
            _switchState = null;
            WidgetsBinding.instance
                .addPostFrameCallback((_) => _loadSwitchState(profile.userId));
          }
          return Column(
            children: [
              50.sH,
              Builder(builder: (context) {
                return EditProfileButton(
                  profile: profile,
                  business:
                      _switchState?.businessActive == true ? _business : null,
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
                      label: 'My Wallet',
                      icon: IconlyLight.wallet,
                      onTap: () {
                        context.router.push(const MyWalletRoute());
                      },
                    ),
                    _MenuButton(
                      label: 'My Community',
                      icon: BootstrapIcons.people,
                      onTap: () {
                        context.router.push(const MyCommunityRoute());
                      },
                    ),
                    _MenuButton(
                      label: 'Messages',
                      icon: IconlyLight.message,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const ConversationsScreen(),
                          ),
                        );
                      },
                    ),
                    if (profile.role == UserRole.Admin)
                      _MenuButton(
                        label: 'Message Review',
                        icon: BootstrapIcons.flag,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => const DmReviewScreen(),
                            ),
                          );
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
                      onTap: () => _onGetInvolvedTapped(context, profile),
                    ),
                    // Only once a Get Involved application has been approved.
                    if (_switchState?.available == true)
                      _MenuButton(
                        label: 'Switch Profile',
                        icon: BootstrapIcons.arrow_left_right,
                        onTap: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) =>
                                  SwitchProfileScreen(profile: profile),
                            ),
                          );
                          if (mounted) _loadSwitchState();
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
                        context.router.push(TermsOfServiceRoute());
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
                isVisible: true,
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
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    // if (!isVisible) return const SizedBox.shrink();
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
    this.icon,
    this.showBorder = true,
    required this.label,
    required this.onTap,
    required this.isVisible,
  });
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool isVisible;
  final bool showBorder;

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
