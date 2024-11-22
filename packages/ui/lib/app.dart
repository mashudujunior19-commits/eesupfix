import 'package:data/auth/data_source/auth_supabase_data_source.dart';
import 'package:data/auth/data_source/profile_supabase_impl.dart';
import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/auth/repository/profile_repository.dart';
import 'package:data/eesupools/data_source/eesupool_supabase_impl.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:data/finance/data_source/wallet_supabase_impl.dart';
import 'package:data/finance/repository/payment_gateway_repository.dart';
import 'package:data/finance/repository/wallets_repository.dart';
import 'package:data/geolocation/data_source/geo_supabase_impl.dart';
import 'package:data/geolocation/repository/geo_repository.dart';
import 'package:data/notifications/data_source/notification_supabase_impl.dart';
import 'package:data/notifications/repository/notification_repository.dart';
import 'package:data/notifications/repository/survey_repository.dart';
import 'package:data/orders/data_source/orders_supabase_impl.dart';
import 'package:data/orders/repository/order_repository.dart';
import 'package:data/partners/data_source/partner_supabase_impl.dart';
import 'package:data/partners/repository/partner_repository.dart';
import 'package:data/shopping/data_source/shopping_supabase_impl.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:data/surveys/data_source/survey_supabase_impl.dart';
import 'package:ui/app_route.dart';
import 'package:ui/src/core/env/app_type.dart';
import 'package:ui/src/core/extensions/context_environment_ext.dart';
import 'package:ui/src/core/themes/eesup_light_theme.dart';
import 'package:ui/src/core/themes/my_kasi_light_theme.dart';
import 'package:ui/app_route.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ui/src/views/auth/profile/bloc/profile_bloc.dart';
import 'package:ui/src/views/auth/sign_in/bloc/auth_bloc.dart';
import 'package:ui/src/views/finances/allocations/bloc/profit_allocation_bloc.dart';
import 'package:ui/src/views/finances/wallets/bloc/wallets_bloc.dart';
import 'package:ui/src/views/notifications/bloc/notifications_bloc.dart';
import 'package:ui/src/views/shop/browsing/bloc/products_filter_bloc.dart';
import 'package:ui/src/views/shop/cart/bloc/cart_bloc.dart';
import 'package:ui/src/views/shop/hampers/bloc/hamper_bloc.dart';

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

  final _profileRepo = RepositoryProvider(
    create: (context) => ProfileRepository(
      context.read<AuthRepository>(),
      ProfileSupabaseImpl(GetIt.I.get<SupabaseClient>()),
    ),
  );

  final _geoRepo = RepositoryProvider(
    create: (context) => GeoRepository(
      GeoSupabaseImpl(GetIt.I.get<SupabaseClient>()),
      context.read<AuthRepository>(),
    ),
  );

  final _walletsRepo = RepositoryProvider(
    create: (context) => WalletsRepository(
      WalletSupabaseImpl(GetIt.I.get<SupabaseClient>()),
      context.read<AuthRepository>(),
    ),
  );

  final _paymentGatewayRepo = RepositoryProvider(
    create: (context) => PaymentGatewayRepo(
      context.read<AuthRepository>(),
      WalletSupabaseImpl(GetIt.I.get<SupabaseClient>()),
    ),
  );

  final _partnerRepository = RepositoryProvider(
    create: (context) => PartnerRepository(
      PartnerSupabaseImpl(GetIt.I.get<SupabaseClient>()),
      context.read<AuthRepository>(),
    ),
  );

  final _surveysRepository = RepositoryProvider(
    create: (context) => SurveyRepository(
      SurveySupabaseImpl(GetIt.I.get<SupabaseClient>()),
      context.read<AuthRepository>(),
    ),
  );

  final _notificationRepo = RepositoryProvider(
    create: (context) => NotificationRepo(
      context.read<AuthRepository>(),
      NotificationSupabaseImpl(GetIt.I.get<SupabaseClient>()),
    ),
  );

  final _hamperRepo = RepositoryProvider(
    create: (context) => ShoppingRepository(
      ShoppingSupabaseImp(
        GetIt.I.get<SupabaseClient>(),
      ),
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
      providers: [
        _authRepo,
        _profileRepo,
        _shoppingRepo,
        _eesupoolRepo,
        _ordersRepo,
        _geoRepo,
        _walletsRepo,
        _paymentGatewayRepo,
        _partnerRepository,
        _surveysRepository,
        _notificationRepo,
        _hamperRepo
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthBloc(context.read<AuthRepository>())..add(AppStarted()),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(
              context.read<ProfileRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => NotificationsBloc(
              context.read<NotificationRepo>(),
            )..add(NotificationStreamStarted()),
          ),
          BlocProvider(
            create: (context) => ProfitAllocationBloc(
              context.read<ProfileRepository>(),
              context.read<WalletsRepository>(),
            )..add(ProfitAllocationsFetched()),
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
          BlocProvider(
              create: (context) =>
                  CartBloc(context.read<ShoppingRepository>())),
          BlocProvider(
            create: (context) => WalletsBloc(context.read<WalletsRepository>()),
          ),
          BlocProvider(
            create: (context) => ProductsFilterBloc(),
          ),
          BlocProvider(
            create: (context) => HamperBloc(context.read<ShoppingRepository>())
              ..add(FetchHampers()),
            create: (context) => HamperBloc(
              context.read<ShoppingRepository>(),
            ),
          ),
        ],

        ///This is the global loader overlay, it is used to show a loading animation
        child: SafeArea(
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
