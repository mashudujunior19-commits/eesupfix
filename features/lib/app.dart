import 'package:data_sources/auth/data_source/auth_supabase_data_source.dart';
import 'package:data_sources/auth/data_source/profile_supabase_impl.dart';
import 'package:data_sources/eesupools/data_source/eesupool_supabase_impl.dart';
import 'package:data_sources/orders/data_source/orders_supabase_impl.dart';
import 'package:data_sources/shopping/data_source/shopping_supabase_impl.dart';
import 'package:features/core/env/app_type.dart';
import 'package:features/core/extensions/context_environment_ext.dart';
import 'package:features/core/themes/eesup_light_theme.dart';
import 'package:features/core/themes/my_kasi_light_theme.dart';
import 'package:features/shop/cart/bloc/cart_bloc.dart';
import 'package:repository/auth/profile_repository.dart';
import 'package:repository/eesupools/eesupool_repo.dart';
import 'package:repository/orders/order_repository.dart';
import 'package:repository/shop/shopping_repository.dart';
import 'package:features/auth/profile/bloc/profile_bloc.dart';
import 'package:features/auth/sign_in/bloc/auth_bloc.dart';
import 'package:features/core/navigation/app_route.dart';
import 'package:features/core/navigation/app_route.gr.dart';
import 'package:repository/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final _appRouter = AppRouter();

  final _authRepo = RepositoryProvider(
    create: (context) => AuthRepository(
      supaSource: AuthSupabaseDataSource(
        client: GetIt.I.get<SupabaseClient>(),
      ),
    ),
  );

  final _shoppingRepo = RepositoryProvider(
    create: (context) => ShoppingRepository(
      ShoppingSupabaseImp(
        GetIt.I.get<SupabaseClient>(),
      ),
      context.read<AuthRepository>(),
    ),
  );

  final _eesupoolRepo = RepositoryProvider(
    create: (context) => EESUpoolRepository(
      authRepository: context.read<AuthRepository>(),
      dataSource: EESUpoolSupabaseImp(
        client: GetIt.I.get<SupabaseClient>(),
      ),
    ),
  );

  final _ordersRepo = RepositoryProvider(
    create: (context) => OrderRepository(
      OrdersSupabaseImpl(GetIt.I.get<SupabaseClient>()),
      context.read<AuthRepository>(),
    ),
  );
  @override
  Widget build(BuildContext context) {
    ///get the correct theme based on the app type (eesup or my kasi)
    final theme = context.environment.app == AppType.eesup
        ? EESUpLightTheme
        : MyKasiLightTheme;

    return MultiRepositoryProvider(
      providers: [_authRepo, _shoppingRepo, _eesupoolRepo, _ordersRepo],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(context.read<AuthRepository>())
              ..add(
                AppStarted(),
              ),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(
              ProfileRepository(
                context.read<AuthRepository>(),
                ProfileSupabaseImpl(
                  GetIt.I.get<SupabaseClient>(),
                ),
              ),
            ),
          ),
          BlocProvider(create: (context) => CartBloc()),
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
                  //  if (_appRouter.stack.isNotEmpty) {

                  _appRouter.push(const ShopOverviewRoute());
                  // }
                }
              }
            },
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: theme,
              routerConfig: _appRouter.config(),
            ),
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
