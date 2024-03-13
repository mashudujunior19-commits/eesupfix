// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:eesup_ui_library/features/auth/reset_password/reset_password_screen.dart'
    as _i3;
import 'package:eesup_ui_library/features/auth/sign_in/sign_in_screen.dart'
    as _i5;
import 'package:eesup_ui_library/features/auth/start_up_screen.dart' as _i6;
import 'package:eesup_ui_library/features/finances/instapay/instapay_screen.dart'
    as _i1;
import 'package:eesup_ui_library/features/referrals/presentation/referrals_screen.dart'
    as _i2;
import 'package:eesup_ui_library/features/shop/overview/presentation/shop_overview_screen.dart'
    as _i4;
import 'package:flutter/material.dart' as _i8;
import 'package:instapay_flutter/data/merchant_transaction.dart' as _i9;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    InstapayRoute.name: (routeData) {
      final args = routeData.argsAs<InstapayRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.InstapayScreen(
          key: args.key,
          transaction: args.transaction,
        ),
      );
    },
    ReferralsRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ReferralsScreen(),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.ResetPasswordScreen(),
      );
    },
    ShopOverviewRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.ShopOverviewScreen(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.SignInScreen(),
      );
    },
    StartUpRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.StartUpScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.InstapayScreen]
class InstapayRoute extends _i7.PageRouteInfo<InstapayRouteArgs> {
  InstapayRoute({
    _i8.Key? key,
    required _i9.MerchantTransaction transaction,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          InstapayRoute.name,
          args: InstapayRouteArgs(
            key: key,
            transaction: transaction,
          ),
          initialChildren: children,
        );

  static const String name = 'InstapayRoute';

  static const _i7.PageInfo<InstapayRouteArgs> page =
      _i7.PageInfo<InstapayRouteArgs>(name);
}

class InstapayRouteArgs {
  const InstapayRouteArgs({
    this.key,
    required this.transaction,
  });

  final _i8.Key? key;

  final _i9.MerchantTransaction transaction;

  @override
  String toString() {
    return 'InstapayRouteArgs{key: $key, transaction: $transaction}';
  }
}

/// generated route for
/// [_i2.ReferralsScreen]
class ReferralsRoute extends _i7.PageRouteInfo<void> {
  const ReferralsRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ReferralsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReferralsRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ResetPasswordScreen]
class ResetPasswordRoute extends _i7.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.ShopOverviewScreen]
class ShopOverviewRoute extends _i7.PageRouteInfo<void> {
  const ShopOverviewRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ShopOverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShopOverviewRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.SignInScreen]
class SignInRoute extends _i7.PageRouteInfo<void> {
  const SignInRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.StartUpScreen]
class StartUpRoute extends _i7.PageRouteInfo<void> {
  const StartUpRoute({List<_i7.PageRouteInfo>? children})
      : super(
          StartUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartUpRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
