import 'package:eesup_ui_library/core/themes/light_theme.dart';
import 'package:eesup_ui_library/features/auth/sign_in/bloc/auth_bloc.dart';
import 'package:eesup_ui_library/navigation/app_route.dart';
import 'package:eesup_ui_library/navigation/app_route.gr.dart';
import 'package:eesup_repository/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final _appRouter = AppRouter();
  final _authRepo = GetIt.I.get<AuthRepository>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          ///We create the auth bloc and subscribe to the Auth State events
          ///
          create: (context) => AuthBloc(_authRepo)..add(AppStarted()),
        ),
      ],

      ///This is the global loader overlay, it is used to show a loading animation
      child: GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayWidgetBuilder: (progress) {
          return const _LoadingAnimation(
            key: Key('global_loading_animation'),
          );
        },
        child: BlocListener<AuthBloc, AuthBlocState>(
          listener: (context, state) async {
            ///This bloc listner is used to listen to the state of the auth bloc
            ///and navigate to the appropriate screen
            if (state is UnAuthenticated) {
              _appRouter.replaceAll([const SignInRoute()]);
            } else if (state is Authenticated) {
              ///off cause we want to navigate to the shop overview screen, only on start up
              ///if the user is already authenticated and is on another screen
              ///We don't want to navigate to the shop overview screen again, hence the isStartUp check
              if (state.isStartUp) {
                //await Future.delayed(const Duration(seconds: 3));
                _appRouter.push(const ShopOverviewRoute());
              }
            }
          },
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            routerConfig: _appRouter.config(),
          ),
        ),
      ),
    );
  }
}

class _LoadingAnimation extends StatelessWidget {
  const _LoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: LoadingAnimationWidget.discreteCircle(
            color: const Color.fromRGBO(48, 142, 88, 1),
            secondRingColor: Colors.red,
            thirdRingColor: Colors.blue,
            size: 30,
          ),
        ),
      ),
    );
  }
}
