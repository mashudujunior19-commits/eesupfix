// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:eesup_ui_library/features/auth/reset_password/reset_password_screen.dart'
    as _i1;
import 'package:eesup_ui_library/features/auth/sign_in/sign_in_screen.dart'
    as _i3;
import 'package:eesup_ui_library/features/auth/start_up_screen.dart' as _i4;
import 'package:eesup_ui_library/features/shop/presentation/shop_overview_screen.dart'
    as _i2;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    ResetPasswordRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ResetPasswordScreen(),
      );
    },
    ShopOverviewRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ShopOverviewScreen(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.SignInScreen(),
      );
    },
    StartUpRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.StartUpScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.ResetPasswordScreen]
class ResetPasswordRoute extends _i5.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i5.PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ShopOverviewScreen]
class ShopOverviewRoute extends _i5.PageRouteInfo<void> {
  const ShopOverviewRoute({List<_i5.PageRouteInfo>? children})
      : super(
          ShopOverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShopOverviewRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SignInScreen]
class SignInRoute extends _i5.PageRouteInfo<void> {
  const SignInRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.StartUpScreen]
class StartUpRoute extends _i5.PageRouteInfo<void> {
  const StartUpRoute({List<_i5.PageRouteInfo>? children})
      : super(
          StartUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartUpRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
