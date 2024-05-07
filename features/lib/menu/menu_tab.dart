// ignore_for_file: unused_element
import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:features/auth/sign_in/bloc/auth_bloc.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/app_route.gr.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
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
                  context.router.push(const BasketsList());
                },
              ),
              _MenuButton(
                label: 'Surveys',
                icon: IconlyLight.chart,
                onTap: () {},
              ),
              _MenuButton(
                label: 'Get Involved',
                icon: IconlyLight.work,
                onTap: () {},
              ),
              _MenuButton(
                label: 'Request Products',
                icon: IconlyLight.plus,
                onTap: () {},
              ),
              _MenuButton(
                label: 'Settings',
                icon: IconlyLight.setting,
                onTap: () {
                  context.router.push(const SettingsRoutes());
                },
              ),
              _MenuButton(
                label: 'Support',
                icon: IconlyLight.user3,
                onTap: () {},
              ),
              _MenuButton(
                label: 'Legal',
                icon: IconlyLight.document,
                onTap: () {},
              ),
            ],
          ),
        ),
        _MenuButtonTile(
          showBorder: false,
          icon: IconlyLight.logout,
          label: 'Sign out',
          onTap: () {
            context.read<AuthBloc>().add(SignOutPressed());
          },
        )
      ],
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
