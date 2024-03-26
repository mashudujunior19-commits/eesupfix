// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i18;
import 'package:data_sources/eesupools/models/eesupool.dart' as _i20;
import 'package:data_sources/finance/models/wallet.dart' as _i24;
import 'package:data_sources/orders/models/order.dart' as _i22;
import 'package:data_sources/partners/models/partner.dart' as _i23;
import 'package:features/auth/reset_password/reset_password_screen.dart'
    as _i11;
import 'package:features/auth/sign_in/sign_in_screen.dart' as _i13;
import 'package:features/auth/start_up_screen.dart' as _i14;
import 'package:features/core/widgets/media_file_uploader.dart' as _i7;
import 'package:features/eesupools/ui/eesupool_view_screen.dart' as _i3;
import 'package:features/finances/crowdvouchers/ui/voucher_view_screen.dart'
    as _i16;
import 'package:features/finances/instapay/instapay_screen.dart' as _i4;
import 'package:features/finances/wallets/ui/screens/transfer_screen.dart'
    as _i15;
import 'package:features/finances/wallets/ui/screens/wallet_view_screen.dart'
    as _i17;
import 'package:features/geolocation/ui/screens/addrese_book_screen.dart'
    as _i1;
import 'package:features/kasipreneur/viewing/ui/eesupreneur_screen.dart' as _i5;
import 'package:features/kasipreneur/viewing/ui/eesupreneur_view_screen.dart'
    as _i6;
import 'package:features/orders/tracking/ui/order_tracking_screen.dart' as _i8;
import 'package:features/partners/ui/partner_apps_screen.dart' as _i9;
import 'package:features/referrals/ui/screens/referrals_screen.dart' as _i10;
import 'package:features/shop/cart/ui/cart_screen.dart' as _i2;
import 'package:features/shop/overview/ui/shop_overview_screen.dart' as _i12;
import 'package:flutter/material.dart' as _i19;
import 'package:instapay_flutter/data/merchant_transaction.dart' as _i21;

abstract class $AppRouter extends _i18.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i18.PageFactory> pagesMap = {
    AddressBookRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddressBookScreen(),
      );
    },
    CartRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.CartScreen(),
      );
    },
    EESUpoolViewRoute.name: (routeData) {
      final args = routeData.argsAs<EESUpoolViewRouteArgs>(
          orElse: () => const EESUpoolViewRouteArgs());
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.EESUpoolViewScreen(
          key: args.key,
          poolId: args.poolId,
          pool: args.pool,
        ),
      );
    },
    InstapayRoute.name: (routeData) {
      final args = routeData.argsAs<InstapayRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.InstapayScreen(
          key: args.key,
          transaction: args.transaction,
        ),
      );
    },
    KasipreneurRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.KasipreneurScreen(),
      );
    },
    KasipreneurViewRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.KasipreneurViewScreen(),
      );
    },
    MediaFilePreviewUploaderRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.MediaFilePreviewUploaderScreen(),
      );
    },
    OrderTrackingRoute.name: (routeData) {
      final args = routeData.argsAs<OrderTrackingRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.OrderTrackingScreen(
          key: args.key,
          order: args.order,
          privilage: args.privilage,
        ),
      );
    },
    PartnerAppRoute.name: (routeData) {
      final args = routeData.argsAs<PartnerAppRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.PartnerAppScreen(
          key: args.key,
          partner: args.partner,
        ),
      );
    },
    ReferralsView.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.ReferralsView(),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.ResetPasswordScreen(),
      );
    },
    ShopOverviewRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.ShopOverviewScreen(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.SignInScreen(),
      );
    },
    StartUpRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.StartUpScreen(),
      );
    },
    TransferRoute.name: (routeData) {
      final args = routeData.argsAs<TransferRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.TransferScreen(
          key: args.key,
          wallet: args.wallet,
        ),
      );
    },
    VoucherViewRoute.name: (routeData) {
      final args = routeData.argsAs<VoucherViewRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.VoucherViewScreen(
          key: args.key,
          voucherId: args.voucherId,
        ),
      );
    },
    WalletViewRoute.name: (routeData) {
      final args = routeData.argsAs<WalletViewRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.WalletViewScreen(
          key: args.key,
          wallet: args.wallet,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.AddressBookScreen]
class AddressBookRoute extends _i18.PageRouteInfo<void> {
  const AddressBookRoute({List<_i18.PageRouteInfo>? children})
      : super(
          AddressBookRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddressBookRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i2.CartScreen]
class CartRoute extends _i18.PageRouteInfo<void> {
  const CartRoute({List<_i18.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i3.EESUpoolViewScreen]
class EESUpoolViewRoute extends _i18.PageRouteInfo<EESUpoolViewRouteArgs> {
  EESUpoolViewRoute({
    _i19.Key? key,
    int? poolId,
    _i20.EESUpool? pool,
    List<_i18.PageRouteInfo>? children,
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

  static const _i18.PageInfo<EESUpoolViewRouteArgs> page =
      _i18.PageInfo<EESUpoolViewRouteArgs>(name);
}

class EESUpoolViewRouteArgs {
  const EESUpoolViewRouteArgs({
    this.key,
    this.poolId,
    this.pool,
  });

  final _i19.Key? key;

  final int? poolId;

  final _i20.EESUpool? pool;

  @override
  String toString() {
    return 'EESUpoolViewRouteArgs{key: $key, poolId: $poolId, pool: $pool}';
  }
}

/// generated route for
/// [_i4.InstapayScreen]
class InstapayRoute extends _i18.PageRouteInfo<InstapayRouteArgs> {
  InstapayRoute({
    _i19.Key? key,
    required _i21.MerchantTransaction transaction,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          InstapayRoute.name,
          args: InstapayRouteArgs(
            key: key,
            transaction: transaction,
          ),
          initialChildren: children,
        );

  static const String name = 'InstapayRoute';

  static const _i18.PageInfo<InstapayRouteArgs> page =
      _i18.PageInfo<InstapayRouteArgs>(name);
}

class InstapayRouteArgs {
  const InstapayRouteArgs({
    this.key,
    required this.transaction,
  });

  final _i19.Key? key;

  final _i21.MerchantTransaction transaction;

  @override
  String toString() {
    return 'InstapayRouteArgs{key: $key, transaction: $transaction}';
  }
}

/// generated route for
/// [_i5.KasipreneurScreen]
class KasipreneurRoute extends _i18.PageRouteInfo<void> {
  const KasipreneurRoute({List<_i18.PageRouteInfo>? children})
      : super(
          KasipreneurRoute.name,
          initialChildren: children,
        );

  static const String name = 'KasipreneurRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i6.KasipreneurViewScreen]
class KasipreneurViewRoute extends _i18.PageRouteInfo<void> {
  const KasipreneurViewRoute({List<_i18.PageRouteInfo>? children})
      : super(
          KasipreneurViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'KasipreneurViewRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i7.MediaFilePreviewUploaderScreen]
class MediaFilePreviewUploaderRoute extends _i18.PageRouteInfo<void> {
  const MediaFilePreviewUploaderRoute({List<_i18.PageRouteInfo>? children})
      : super(
          MediaFilePreviewUploaderRoute.name,
          initialChildren: children,
        );

  static const String name = 'MediaFilePreviewUploaderRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i8.OrderTrackingScreen]
class OrderTrackingRoute extends _i18.PageRouteInfo<OrderTrackingRouteArgs> {
  OrderTrackingRoute({
    _i19.Key? key,
    required _i22.Order order,
    required _i22.OrderEditPrivilage privilage,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          OrderTrackingRoute.name,
          args: OrderTrackingRouteArgs(
            key: key,
            order: order,
            privilage: privilage,
          ),
          initialChildren: children,
        );

  static const String name = 'OrderTrackingRoute';

  static const _i18.PageInfo<OrderTrackingRouteArgs> page =
      _i18.PageInfo<OrderTrackingRouteArgs>(name);
}

class OrderTrackingRouteArgs {
  const OrderTrackingRouteArgs({
    this.key,
    required this.order,
    required this.privilage,
  });

  final _i19.Key? key;

  final _i22.Order order;

  final _i22.OrderEditPrivilage privilage;

  @override
  String toString() {
    return 'OrderTrackingRouteArgs{key: $key, order: $order, privilage: $privilage}';
  }
}

/// generated route for
/// [_i9.PartnerAppScreen]
class PartnerAppRoute extends _i18.PageRouteInfo<PartnerAppRouteArgs> {
  PartnerAppRoute({
    _i19.Key? key,
    required _i23.Partner partner,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          PartnerAppRoute.name,
          args: PartnerAppRouteArgs(
            key: key,
            partner: partner,
          ),
          initialChildren: children,
        );

  static const String name = 'PartnerAppRoute';

  static const _i18.PageInfo<PartnerAppRouteArgs> page =
      _i18.PageInfo<PartnerAppRouteArgs>(name);
}

class PartnerAppRouteArgs {
  const PartnerAppRouteArgs({
    this.key,
    required this.partner,
  });

  final _i19.Key? key;

  final _i23.Partner partner;

  @override
  String toString() {
    return 'PartnerAppRouteArgs{key: $key, partner: $partner}';
  }
}

/// generated route for
/// [_i10.ReferralsView]
class ReferralsView extends _i18.PageRouteInfo<void> {
  const ReferralsView({List<_i18.PageRouteInfo>? children})
      : super(
          ReferralsView.name,
          initialChildren: children,
        );

  static const String name = 'ReferralsView';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i11.ResetPasswordScreen]
class ResetPasswordRoute extends _i18.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i18.PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i12.ShopOverviewScreen]
class ShopOverviewRoute extends _i18.PageRouteInfo<void> {
  const ShopOverviewRoute({List<_i18.PageRouteInfo>? children})
      : super(
          ShopOverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShopOverviewRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i13.SignInScreen]
class SignInRoute extends _i18.PageRouteInfo<void> {
  const SignInRoute({List<_i18.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i14.StartUpScreen]
class StartUpRoute extends _i18.PageRouteInfo<void> {
  const StartUpRoute({List<_i18.PageRouteInfo>? children})
      : super(
          StartUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartUpRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i15.TransferScreen]
class TransferRoute extends _i18.PageRouteInfo<TransferRouteArgs> {
  TransferRoute({
    _i19.Key? key,
    required _i24.Wallet wallet,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          TransferRoute.name,
          args: TransferRouteArgs(
            key: key,
            wallet: wallet,
          ),
          initialChildren: children,
        );

  static const String name = 'TransferRoute';

  static const _i18.PageInfo<TransferRouteArgs> page =
      _i18.PageInfo<TransferRouteArgs>(name);
}

class TransferRouteArgs {
  const TransferRouteArgs({
    this.key,
    required this.wallet,
  });

  final _i19.Key? key;

  final _i24.Wallet wallet;

  @override
  String toString() {
    return 'TransferRouteArgs{key: $key, wallet: $wallet}';
  }
}

/// generated route for
/// [_i16.VoucherViewScreen]
class VoucherViewRoute extends _i18.PageRouteInfo<VoucherViewRouteArgs> {
  VoucherViewRoute({
    _i19.Key? key,
    required int voucherId,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          VoucherViewRoute.name,
          args: VoucherViewRouteArgs(
            key: key,
            voucherId: voucherId,
          ),
          initialChildren: children,
        );

  static const String name = 'VoucherViewRoute';

  static const _i18.PageInfo<VoucherViewRouteArgs> page =
      _i18.PageInfo<VoucherViewRouteArgs>(name);
}

class VoucherViewRouteArgs {
  const VoucherViewRouteArgs({
    this.key,
    required this.voucherId,
  });

  final _i19.Key? key;

  final int voucherId;

  @override
  String toString() {
    return 'VoucherViewRouteArgs{key: $key, voucherId: $voucherId}';
  }
}

/// generated route for
/// [_i17.WalletViewScreen]
class WalletViewRoute extends _i18.PageRouteInfo<WalletViewRouteArgs> {
  WalletViewRoute({
    _i19.Key? key,
    required _i24.Wallet wallet,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          WalletViewRoute.name,
          args: WalletViewRouteArgs(
            key: key,
            wallet: wallet,
          ),
          initialChildren: children,
        );

  static const String name = 'WalletViewRoute';

  static const _i18.PageInfo<WalletViewRouteArgs> page =
      _i18.PageInfo<WalletViewRouteArgs>(name);
}

class WalletViewRouteArgs {
  const WalletViewRouteArgs({
    this.key,
    required this.wallet,
  });

  final _i19.Key? key;

  final _i24.Wallet wallet;

  @override
  String toString() {
    return 'WalletViewRouteArgs{key: $key, wallet: $wallet}';
  }
}
