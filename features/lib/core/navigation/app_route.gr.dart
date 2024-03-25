// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:data_sources/eesupools/models/eesupool.dart' as _i11;
import 'package:features/auth/reset_password/reset_password_screen.dart' as _i5;
import 'package:features/auth/sign_in/sign_in_screen.dart' as _i7;
import 'package:features/auth/start_up_screen.dart' as _i8;
import 'package:features/core/widgets/media_file_uploader.dart' as _i3;
import 'package:features/eesupools/viewing/ui/eesupool_view_screen.dart'
    as _i1;
import 'package:features/finances/instapay/instapay_screen.dart' as _i2;
import 'package:features/referrals/ui/referrals_screen.dart' as _i4;
import 'package:features/shop/overview/ui/shop_overview_screen.dart'
    as _i6;
import 'package:flutter/material.dart' as _i10;
import 'package:instapay_flutter/data/merchant_transaction.dart' as _i12;

abstract class $AppRouter extends _i9.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    EESUpoolViewRoute.name: (routeData) {
      final args = routeData.argsAs<EESUpoolViewRouteArgs>(
          orElse: () => const EESUpoolViewRouteArgs());
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.EESUpoolViewScreen(
          key: args.key,
          poolId: args.poolId,
          pool: args.pool,
        ),
      );
    },
    InstapayRoute.name: (routeData) {
      final args = routeData.argsAs<InstapayRouteArgs>();
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.InstapayScreen(
          key: args.key,
          transaction: args.transaction,
        ),
      );
    },
    MediaFilePreviewUploaderRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.MediaFilePreviewUploaderScreen(),
      );
    },
    ReferralsRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.ReferralsScreen(),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.ResetPasswordScreen(),
      );
    },
    ShopOverviewRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ShopOverviewScreen(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.SignInScreen(),
      );
    },
    StartUpRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.StartUpScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.EESUpoolViewScreen]
class EESUpoolViewRoute extends _i9.PageRouteInfo<EESUpoolViewRouteArgs> {
  EESUpoolViewRoute({
    _i10.Key? key,
    int? poolId,
    _i11.EESUpool? pool,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          EESUpoolViewRoute.name,
          args: EESUpoolViewRouteArgs(
            key: key,
            poolId: poolId,
            pool: pool,
          ),
          initialChildren: children,
        );

  static const String name = 'EESUpoolViewRoute';

  static const _i9.PageInfo<EESUpoolViewRouteArgs> page =
      _i9.PageInfo<EESUpoolViewRouteArgs>(name);
}

class EESUpoolViewRouteArgs {
  const EESUpoolViewRouteArgs({
    this.key,
    this.poolId,
    this.pool,
  });

  final _i10.Key? key;

  final int? poolId;

  final _i11.EESUpool? pool;

  @override
  String toString() {
    return 'EESUpoolViewRouteArgs{key: $key, poolId: $poolId, pool: $pool}';
  }
}

/// generated route for
/// [_i2.InstapayScreen]
class InstapayRoute extends _i9.PageRouteInfo<InstapayRouteArgs> {
  InstapayRoute({
    _i10.Key? key,
    required _i12.MerchantTransaction transaction,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          InstapayRoute.name,
          args: InstapayRouteArgs(
            key: key,
            transaction: transaction,
          ),
          initialChildren: children,
        );

  static const String name = 'InstapayRoute';

  static const _i9.PageInfo<InstapayRouteArgs> page =
      _i9.PageInfo<InstapayRouteArgs>(name);
}

class InstapayRouteArgs {
  const InstapayRouteArgs({
    this.key,
    required this.transaction,
  });

  final _i10.Key? key;

  final _i12.MerchantTransaction transaction;

  @override
  String toString() {
    return 'InstapayRouteArgs{key: $key, transaction: $transaction}';
  }
}

/// generated route for
/// [_i3.MediaFilePreviewUploaderScreen]
class MediaFilePreviewUploaderRoute extends _i9.PageRouteInfo<void> {
  const MediaFilePreviewUploaderRoute({List<_i9.PageRouteInfo>? children})
      : super(
          MediaFilePreviewUploaderRoute.name,
          initialChildren: children,
        );

  static const String name = 'MediaFilePreviewUploaderRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i4.ReferralsScreen]
class ReferralsRoute extends _i9.PageRouteInfo<void> {
  const ReferralsRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ReferralsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReferralsRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ResetPasswordScreen]
class ResetPasswordRoute extends _i9.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ShopOverviewScreen]
class ShopOverviewRoute extends _i9.PageRouteInfo<void> {
  const ShopOverviewRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ShopOverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShopOverviewRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SignInScreen]
class SignInRoute extends _i9.PageRouteInfo<void> {
  const SignInRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i8.StartUpScreen]
class StartUpRoute extends _i9.PageRouteInfo<void> {
  const StartUpRoute({List<_i9.PageRouteInfo>? children})
      : super(
          StartUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartUpRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}
