import 'package:auto_route/auto_route.dart';
import 'package:eesup/src/features/auth/sign_in/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ShopOverviewScreen extends StatefulWidget {
  const ShopOverviewScreen({super.key});

  @override
  State<ShopOverviewScreen> createState() => _ShopOverviewScreenState();
}

class _ShopOverviewScreenState extends State<ShopOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: const Key('shop_overview_screen'),
      child: Scaffold(
        body: TextButton(
          child: const Text('Sign out'),
          onPressed: () {
            context.read<AuthBloc>().add(SignOutPressed());
          },
        ),
      ),
    );
  }
}
