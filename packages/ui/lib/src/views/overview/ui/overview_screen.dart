import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/widgets/eesup_scaffold.dart';
import 'package:ui/src/views/eesupools/ui/my_kasi_tab.dart';
import 'package:ui/src/views/menu/menu_tab.dart';
import 'package:ui/src/views/overview/ui/my_kasi_shop.dart';
import 'package:ui/src/views/overview/ui/widgets/bottom_tab_bar.dart';
import 'package:ui/src/views/overview/ui/overview_tab.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/fullscreen_loading_shimmer.dart';
import '../../auth/profile/bloc/edit_profile_bloc.dart';
import '../../auth/profile/bloc/profile_bloc.dart';

@RoutePage()
class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });

    context.read<ProfileBloc>().add(ProfileFetched());
    context.read<EditProfileBloc>().add(CheckIfHasAddress());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: const Key('shop_overview_screen'),
      child: MultiBlocListener(
        listeners: [
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileLoaded) {
                if (state.profile.rsaIdNumber == null ||
                    state.profile.rsaIdNumber!.isEmpty) {
                  if (state.profile.foreigner == false ||
                      state.profile.foreigner == null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Update Your RSA ID'),
                          content: const Text(
                              'You do not have an RSA ID registered.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                context.router.push(
                                  EditProfileRoute(profile: state.profile),
                                );
                              },
                              child: const Text('Update RSA ID'),
                            ),
                            TextButton(
                              onPressed: () {
                                final editProfileBloc =
                                    context.read<EditProfileBloc>();
                                final updatedProfile =
                                    state.profile.copyWith(foreigner: true);

                                editProfileBloc
                                    .add(ProfileEdited(updatedProfile));
                                editProfileBloc.add(
                                    ProfileSaved(state.profile.rsaIdNumber));

                                Navigator.pop(context);
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                                // backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Foreigner'),
                            ),
                          ],
                        ),
                      );
                    });
                  }
                }
              }
            },
          ),
          BlocListener<EditProfileBloc, EditProfileState>(
            listener: (context, state) {
              if (state is AddressMissingState) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Add Your Address'),
                      content: const Text(
                          'You do not have an address registered. Would you like to add it now?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            context.router.push(EditAddressRoute());
                          },
                          child: const Text('Add Address'),
                        ),
                      ],
                    ),
                  );
                });
              }
            },
          ),
        ],
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const FullScreenLoadingShimmer();
            } else if (state is ProfileLoaded) {
              return Container(
                decoration: context.bgImage,
                child: EESUpScaffold(
                  backgroundColor: Colors.transparent,
                  bottomNavigationBar:
                      BottomTabBar(tabController: _tabController),
                  body: TabBarView(
                    controller: _tabController,
                    children: const [
                      OverviewTab(),
                      MyKasiTab(),
                      MyKasiShop(),
                      MenuTab(),
                    ],
                  ),
                ),
              );
            } else if (state is ProfileError) {
              return Center(child: Text(state.ex.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}

// @RoutePage()
// class OverviewScreen extends StatefulWidget {
//   const OverviewScreen({super.key});

//   @override
//   State<OverviewScreen> createState() => _OverviewScreenState();
// }

// class _OverviewScreenState extends State<OverviewScreen>
//     with SingleTickerProviderStateMixin {
//   late final TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
//     _tabController.addListener(() {
//       if (_tabController.indexIsChanging) {
//         setState(() {});
//       }
//     });
//     context.read<ProfileBloc>().add(ProfileFetched());
//     context.read<EditProfileBloc>().add(CheckIfHasAddress());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       key: const Key('shop_overview_screen'),
//       child: BlocListener<ProfileBloc, ProfileState>(
//         listener: (context, state) {
//           if (state is ProfileLoaded) {
//             print('first state: $state');
//             if (state.profile.rsaIdNumber == null ||
//                 state.profile.rsaIdNumber!.isEmpty) {
//               if (state.profile.foreigner == false ||
//                   state.profile.foreigner == null) {
//                 WidgetsBinding.instance.addPostFrameCallback((_) {
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       title: const Text('Update Your RSA ID'),
//                       content:
//                           const Text('You do not have an RSA ID registered.'),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                             context.router
//                                 .push(EditProfileRoute(profile: state.profile));
//                           },
//                           child: const Text('Update RSA ID'),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             final editProfileBloc =
//                                 context.read<EditProfileBloc>();
//                             final updatedProfile =
//                                 state.profile.copyWith(foreigner: true);

//                             editProfileBloc.add(ProfileEdited(updatedProfile));

//                             editProfileBloc
//                                 .add(ProfileSaved(state.profile.rsaIdNumber));

//                             Navigator.pop(context);
//                           },
//                           child: const Text('Foreigner'),
//                         ),
//                       ],
//                     ),
//                   );
//                 });
//               }
//             } else {
//               // print('CheckIfHasAddress event triggered');
//               // final profileBloc = context.read<EditProfileBloc>();
//               // profileBloc.add(CheckIfHasAddress());

//               // if (state is AddressMissingState) {
//               //   print('AddressMissingState received');
//               //   print('state : $state');
//               //   WidgetsBinding.instance.addPostFrameCallback((_) {
//               //     showDialog(
//               //       context: context,
//               //       builder: (context) => AlertDialog(
//               //         title: const Text('Add Your Address'),
//               //         content: const Text(
//               //             'You do not have an address registered. Would you like to add it now?'),
//               //         actions: [
//               //           TextButton(
//               //             onPressed: () {
//               //               Navigator.pop(context);
//               //               context.router.push(EditAddressRoute());
//               //             },
//               //             child: const Text('Add Address'),
//               //           ),
//               //         ],
//               //       ),
//               //     );
//               //   });
//               // }
//             }
//           }

//           ///

//           BlocListener<EditProfileBloc, EditProfileState>(
//               listener: (context, state) {
//             print('EditProfileBloc state: ${state.runtimeType}');
//             if (state is AddressMissingState) {
//               print(' AddressMissingState received');
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     title: const Text('Add Your Address'),
//                     content: const Text(
//                         'You do not have an address registered. Would you like to add it now?'),
//                     actions: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                           context.router.push(EditAddressRoute());
//                         },
//                         child: const Text('Add Address'),
//                       ),
//                     ],
//                   ),
//                 );
//               });
//             }
//           });

//           ///
//         },
//         child: BlocBuilder<ProfileBloc, ProfileState>(
//           builder: (context, state) {
//             if (state is ProfileLoading) {
//               return const FullScreenLoadingShimmer();
//             } else if (state is ProfileLoaded) {
//               return Container(
//                 decoration: context.bgImage,
//                 child: EESUpScaffold(
//                   backgroundColor: Colors.transparent,
//                   bottomNavigationBar:
//                       BottomTabBar(tabController: _tabController),
//                   body: TabBarView(
//                     controller: _tabController,
//                     children: const [
//                       OverviewTab(),
//                       MyKasiTab(),
//                       MyKasiShop(),
//                       MenuTab(),
//                     ],
//                   ),
//                 ),
//               );
//             } else if (state is ProfileError) {
//               return Center(child: Text(state.ex.message));
//             }
//             return Container();
//           },
//         ),
//       ),
//     );
//   }
// }

// @RoutePage()
// class OverviewScreen extends StatefulWidget {
//   const OverviewScreen({super.key});

//   @override
//   State<OverviewScreen> createState() => _OverviewScreenState();
// }

// class _OverviewScreenState extends State<OverviewScreen>
//     with SingleTickerProviderStateMixin {
//   late final TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
//     _tabController.addListener(() {
//       if (_tabController.indexIsChanging) {
//         setState(() {});
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       key: const Key('shop_overview_screen'),
//       child: Container(
//         decoration: context.bgImage,
//         child: EESUpScaffold(
//           backgroundColor: Colors.transparent,
//           bottomNavigationBar: BottomTabBar(tabController: _tabController),
//           body: TabBarView(
//             controller: _tabController,
//             children: const [
//               OverviewTab(),
//               MyKasiTab(),
//               MyKasiShop(),
//               MenuTab(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
