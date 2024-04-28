import 'package:auto_route/auto_route.dart';
import 'package:features/auth/sign_in/bloc/auth_bloc.dart';
import 'package:features/app_route.gr.dart';
import 'package:features/core/widgets/loading_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/auth/auth_repository.dart';

@RoutePage()
class StartUpScreen extends StatelessWidget {
  const StartUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthBlocState>(
      bloc: AuthBloc(context.read<AuthRepository>())..add(AppStarted()),
      listener: (context, state) {
        if (state is UnAuthenticated) {
          context.router.replaceAll([const SignInRoute()]);
        } else if (state is Authenticated) {
          context.router.replaceAll([const OverviewRoute()]);
        }
      },
      child: const SafeArea(
        child: Scaffold(
          key: Key('start_up_screen'),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: Image(
                    image: AssetImage(
                      'assets/images/logo.png',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                LoadingStateWidget(size: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
