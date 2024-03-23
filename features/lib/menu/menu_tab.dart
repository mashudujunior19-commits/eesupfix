import 'package:features/auth/sign_in/bloc/auth_bloc.dart';
import 'package:features/menu/menu_button_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class MenuTab extends StatelessWidget {
  const MenuTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, right: 20, left: 20),
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
              ),
            ],
          ),
        )
      ],
    );
  }
}
