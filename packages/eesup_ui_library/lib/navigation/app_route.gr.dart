// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:eesup_ui_library/features/auth/sign_in/sign_in_screen.dart'
    as _i2;
import 'package:eesup_ui_library/features/auth/start_up_screen.dart' as _i3;
import 'package:eesup_ui_library/features/shop/presentation/shop_overview_screen.dart'
    as _i1;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    ShopOverviewRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ShopOverviewScreen(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.SignInScreen(),
      );
    },
    StartUpRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.StartUpScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.ShopOverviewScreen]
class ShopOverviewRoute extends _i4.PageRouteInfo<void> {
  const ShopOverviewRoute({List<_i4.PageRouteInfo>? children})
      : super(
          ShopOverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShopOverviewRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.SignInScreen]
class SignInRoute extends _i4.PageRouteInfo<void> {
  const SignInRoute({List<_i4.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.StartUpScreen]
class StartUpRoute extends _i4.PageRouteInfo<void> {
  const StartUpRoute({List<_i4.PageRouteInfo>? children})
      : super(
          StartUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartUpRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
