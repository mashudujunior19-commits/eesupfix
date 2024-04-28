import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:features/auth/sign_in/bloc/auth_bloc.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/app_route.gr.dart';
import 'package:features/menu/menu_button.dart';
import 'package:features/menu/menu_button_tile.dart';
import 'package:features/menu/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class MenuTab extends StatelessWidget {
  const MenuTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const EditProfileButton(),
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
              MenuButton(
                label: 'My Addresses',
                icon: IconlyLight.location,
                onTap: () {
                  context.router
                      .push(const AddressBookRoute())
                      .then((value) => null);
                },
              ),
              MenuButton(
                label: 'MyBaskets',
                icon: BootstrapIcons.basket,
                onTap: () {},
              ),
              MenuButton(
                label: 'Surveys',
                icon: IconlyLight.chart,
                onTap: () {},
              ),
              MenuButton(
                label: 'Get Involved',
                icon: IconlyLight.work,
                onTap: () {},
              ),
              MenuButton(
                label: 'Request Products',
                icon: IconlyLight.plus,
                onTap: () {},
              ),
              MenuButton(
                label: 'Settings',
                icon: IconlyLight.setting,
                onTap: () {
                  context.router.push(const SettingsRoutes());
                },
              ),
              MenuButton(
                label: 'Support',
                icon: IconlyLight.user3,
                onTap: () {},
              ),
              MenuButton(
                label: 'Legal',
                icon: IconlyLight.document,
                onTap: () {},
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 25, right: 20, left: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade300,
              width: .5,
            ),
          ),
          child: MenuButtonTile(
            showBorder: false,
            icon: IconlyLight.logout,
            label: 'Sign out',
            onTap: () {
              context.read<AuthBloc>().add(SignOutPressed());
            },
          ),
        )
      ],
    );
  }
}
