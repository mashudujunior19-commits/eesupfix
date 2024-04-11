// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i26;
import 'package:data_sources/eesupools/models/eesupool.dart' as _i30;
import 'package:data_sources/finance/models/wallet.dart' as _i35;
import 'package:data_sources/geolocation/models/address.dart' as _i31;
import 'package:data_sources/orders/models/order.dart' as _i33;
import 'package:data_sources/orders/models/order_product.dart' as _i29;
import 'package:data_sources/partners/models/partner.dart' as _i34;
import 'package:data_sources/shopping/models/basket.dart' as _i28;
import 'package:features/auth/profile/ui/edit_profile_screen.dart' as _i7;
import 'package:features/auth/register/ui/register_screen.dart' as _i17;
import 'package:features/auth/reset_password/reset_password_screen.dart'
    as _i18;
import 'package:features/auth/sign_in/sign_in_screen.dart' as _i20;
import 'package:features/auth/start_up_screen.dart' as _i21;
import 'package:features/core/widgets/media_file_uploader.dart' as _i12;
import 'package:features/eesupools/ui/eesupool_view_screen.dart' as _i5;
import 'package:features/finances/crowdvouchers/ui/voucher_view_screen.dart'
    as _i23;
import 'package:features/finances/payments/instapay/instapay_confirm_profile.dart'
    as _i8;
import 'package:features/finances/payments/instapay/instapay_screen.dart'
    as _i9;
import 'package:features/finances/payments/ozow/ozow_screen.dart' as _i14;
import 'package:features/finances/payments/yoco/yoco_payment_screen.dart'
    as _i25;
import 'package:features/finances/wallets/ui/screens/transfer_screen.dart'
    as _i22;
import 'package:features/finances/wallets/ui/screens/wallet_view_screen.dart'
    as _i24;
import 'package:features/geolocation/ui/screens/addrese_book_screen.dart'
    as _i1;
import 'package:features/geolocation/ui/screens/edit_address_screen.dart'
    as _i6;
import 'package:features/kasipreneur/viewing/ui/eesupreneur_screen.dart'
    as _i10;
import 'package:features/kasipreneur/viewing/ui/eesupreneur_view_screen.dart'
    as _i11;
import 'package:features/orders/tracking/ui/order_tracking_screen.dart' as _i13;
import 'package:features/partners/ui/partner_apps_screen.dart' as _i15;
import 'package:features/referrals/ui/screens/referrals_screen.dart' as _i16;
import 'package:features/shop/baskets/viewing/ui/basket_view_screen.dart'
    as _i2;
import 'package:features/shop/cart/ui/cart_screen.dart' as _i3;
import 'package:features/shop/checkout/ui/checkout_screen.dart' as _i4;
import 'package:features/shop/overview/ui/shop_overview_screen.dart' as _i19;
import 'package:flutter/material.dart' as _i27;
import 'package:instapay_flutter/data/merchant_transaction.dart' as _i32;

abstract class $AppRouter extends _i26.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i26.PageFactory> pagesMap = {
    AddressBookRoute.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddressBookScreen(),
      );
    },
    BasketViewRoute.name: (routeData) {
      final args = routeData.argsAs<BasketViewRouteArgs>();
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.BasketViewScreen(
          key: args.key,
          basket: args.basket,
        ),
      );
    },
    CartRoute.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.CartScreen(),
      );
    },
    CheckoutRoute.name: (routeData) {
      final args = routeData.argsAs<CheckoutRouteArgs>();
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.CheckoutScreen(
          key: args.key,
          products: args.products,
          total: args.total,
        ),
      );
    },
    EESUpoolViewRoute.name: (routeData) {
      final args = routeData.argsAs<EESUpoolViewRouteArgs>(
          orElse: () => const EESUpoolViewRouteArgs());
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.EESUpoolViewScreen(
          key: args.key,
          poolId: args.poolId,
          pool: args.pool,
        ),
      );
    },
    EditAddressRoute.name: (routeData) {
      final args = routeData.argsAs<EditAddressRouteArgs>(
          orElse: () => const EditAddressRouteArgs());
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.EditAddressScreen(
          key: args.key,
          address: args.address,
          isPersonal: args.isPersonal,
        ),
      );
    },
    EditProfileRoute.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.EditProfileScreen(),
      );
    },
    InstapayConfirmDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<InstapayConfirmDetailsRouteArgs>();
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.InstapayConfirmDetailsScreen(
          key: args.key,
          transaction: args.transaction,
        ),
      );
    },
    InstapayRoute.name: (routeData) {
      final args = routeData.argsAs<InstapayRouteArgs>();
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.InstapayScreen(
          key: args.key,
          transaction: args.transaction,
        ),
      );
    },
    KasipreneurRoute.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.KasipreneurScreen(),
      );
    },
    KasipreneurViewRoute.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.KasipreneurViewScreen(),
      );
    },
    MediaFilePreviewUploaderRoute.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.MediaFilePreviewUploaderScreen(),
      );
    },
    OrderTrackingRoute.name: (routeData) {
      final args = routeData.argsAs<OrderTrackingRouteArgs>();
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.OrderTrackingScreen(
          key: args.key,
          order: args.order,
          privilage: args.privilage,
        ),
      );
    },
    OzowRoute.name: (routeData) {
      final args = routeData.argsAs<OzowRouteArgs>();
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.OzowScreen(
          key: args.key,
          reference: args.reference,
          amount: args.amount,
          type: args.type,
          bankRef: args.bankRef,
        ),
      );
    },
    PartnerAppRoute.name: (routeData) {
      final args = routeData.argsAs<PartnerAppRouteArgs>();
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.PartnerAppScreen(
          key: args.key,
          partner: args.partner,
        ),
      );
    },
    ReferralsView.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.ReferralsView(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.RegisterScreen(),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.ResetPasswordScreen(),
      );
    },
    ShopOverviewRoute.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.ShopOverviewScreen(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.SignInScreen(),
      );
    },
    StartUpRoute.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.StartUpScreen(),
      );
    },
    TransferRoute.name: (routeData) {
      final args = routeData.argsAs<TransferRouteArgs>();
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i22.TransferScreen(
          key: args.key,
          wallet: args.wallet,
        ),
      );
    },
    VoucherViewRoute.name: (routeData) {
      final args = routeData.argsAs<VoucherViewRouteArgs>();
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i23.VoucherViewScreen(
          key: args.key,
          voucherId: args.voucherId,
        ),
      );
    },
    WalletViewRoute.name: (routeData) {
      final args = routeData.argsAs<WalletViewRouteArgs>();
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i24.WalletViewScreen(
          key: args.key,
          wallet: args.wallet,
        ),
      );
    },
    YocoPaymentRoute.name: (routeData) {
      final args = routeData.argsAs<YocoPaymentRouteArgs>();
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.YocoPaymentScreen(
          key: args.key,
          reference: args.reference,
          amount: args.amount,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.AddressBookScreen]
class AddressBookRoute extends _i26.PageRouteInfo<void> {
  const AddressBookRoute({List<_i26.PageRouteInfo>? children})
      : super(
          AddressBookRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddressBookRoute';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i2.BasketViewScreen]
class BasketViewRoute extends _i26.PageRouteInfo<BasketViewRouteArgs> {
  BasketViewRoute({
    _i27.Key? key,
    required _i28.Basket basket,
    List<_i26.PageRouteInfo>? children,
  }) : super(
          BasketViewRoute.name,
          args: BasketViewRouteArgs(
            key: key,
            basket: basket,
          ),
          initialChildren: children,
        );

  static const String name = 'BasketViewRoute';

  static const _i26.PageInfo<BasketViewRouteArgs> page =
      _i26.PageInfo<BasketViewRouteArgs>(name);
}

class BasketViewRouteArgs {
  const BasketViewRouteArgs({
    this.key,
    required this.basket,
  });

  final _i27.Key? key;

  final _i28.Basket basket;

  @override
  String toString() {
    return 'BasketViewRouteArgs{key: $key, basket: $basket}';
  }
}

/// generated route for
/// [_i3.CartScreen]
class CartRoute extends _i26.PageRouteInfo<void> {
  const CartRoute({List<_i26.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i4.CheckoutScreen]
class CheckoutRoute extends _i26.PageRouteInfo<CheckoutRouteArgs> {
  CheckoutRoute({
    _i27.Key? key,
    required List<_i29.OrderProduct> products,
    required double total,
    List<_i26.PageRouteInfo>? children,
  }) : super(
          CheckoutRoute.name,
          args: CheckoutRouteArgs(
            key: key,
            products: products,
            total: total,
          ),
          initialChildren: children,
        );

  static const String name = 'CheckoutRoute';

  static const _i26.PageInfo<CheckoutRouteArgs> page =
      _i26.PageInfo<CheckoutRouteArgs>(name);
}

class CheckoutRouteArgs {
  const CheckoutRouteArgs({
    this.key,
    required this.products,
    required this.total,
  });

  final _i27.Key? key;

  final List<_i29.OrderProduct> products;

  final double total;

  @override
  String toString() {
    return 'CheckoutRouteArgs{key: $key, products: $products, total: $total}';
  }
}

/// generated route for
/// [_i5.EESUpoolViewScreen]
class EESUpoolViewRoute extends _i26.PageRouteInfo<EESUpoolViewRouteArgs> {
  EESUpoolViewRoute({
    _i27.Key? key,
    int? poolId,
    _i30.EESUpool? pool,
    List<_i26.PageRouteInfo>? children,
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

  static const _i26.PageInfo<EESUpoolViewRouteArgs> page =
      _i26.PageInfo<EESUpoolViewRouteArgs>(name);
}

class EESUpoolViewRouteArgs {
  const EESUpoolViewRouteArgs({
    this.key,
    this.poolId,
    this.pool,
  });

  final _i27.Key? key;

  final int? poolId;

  final _i30.EESUpool? pool;

  @override
  String toString() {
    return 'EESUpoolViewRouteArgs{key: $key, poolId: $poolId, pool: $pool}';
  }
}

/// generated route for
/// [_i6.EditAddressScreen]
class EditAddressRoute extends _i26.PageRouteInfo<EditAddressRouteArgs> {
  EditAddressRoute({
    _i27.Key? key,
    _i31.Address? address,
    bool isPersonal = true,
    List<_i26.PageRouteInfo>? children,
  }) : super(
          EditAddressRoute.name,
          args: EditAddressRouteArgs(
            key: key,
            address: address,
            isPersonal: isPersonal,
          ),
          initialChildren: children,
        );

  static const String name = 'EditAddressRoute';

  static const _i26.PageInfo<EditAddressRouteArgs> page =
      _i26.PageInfo<EditAddressRouteArgs>(name);
}

class EditAddressRouteArgs {
  const EditAddressRouteArgs({
    this.key,
    this.address,
    this.isPersonal = true,
  });

  final _i27.Key? key;

  final _i31.Address? address;

  final bool isPersonal;

  @override
  String toString() {
    return 'EditAddressRouteArgs{key: $key, address: $address, isPersonal: $isPersonal}';
  }
}

/// generated route for
/// [_i7.EditProfileScreen]
class EditProfileRoute extends _i26.PageRouteInfo<void> {
  const EditProfileRoute({List<_i26.PageRouteInfo>? children})
      : super(
          EditProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i8.InstapayConfirmDetailsScreen]
class InstapayConfirmDetailsRoute
    extends _i26.PageRouteInfo<InstapayConfirmDetailsRouteArgs> {
  InstapayConfirmDetailsRoute({
    _i27.Key? key,
    required _i32.MerchantTransaction transaction,
    List<_i26.PageRouteInfo>? children,
  }) : super(
          InstapayConfirmDetailsRoute.name,
          args: InstapayConfirmDetailsRouteArgs(
            key: key,
            transaction: transaction,
          ),
          initialChildren: children,
        );

  static const String name = 'InstapayConfirmDetailsRoute';

  static const _i26.PageInfo<InstapayConfirmDetailsRouteArgs> page =
      _i26.PageInfo<InstapayConfirmDetailsRouteArgs>(name);
}

class InstapayConfirmDetailsRouteArgs {
  const InstapayConfirmDetailsRouteArgs({
    this.key,
    required this.transaction,
  });

  final _i27.Key? key;

  final _i32.MerchantTransaction transaction;

  @override
  String toString() {
    return 'InstapayConfirmDetailsRouteArgs{key: $key, transaction: $transaction}';
  }
}

/// generated route for
/// [_i9.InstapayScreen]
class InstapayRoute extends _i26.PageRouteInfo<InstapayRouteArgs> {
  InstapayRoute({
    _i27.Key? key,
    required _i32.MerchantTransaction transaction,
    List<_i26.PageRouteInfo>? children,
  }) : super(
          InstapayRoute.name,
          args: InstapayRouteArgs(
            key: key,
            transaction: transaction,
          ),
          initialChildren: children,
        );

  static const String name = 'InstapayRoute';

  static const _i26.PageInfo<InstapayRouteArgs> page =
      _i26.PageInfo<InstapayRouteArgs>(name);
}

class InstapayRouteArgs {
  const InstapayRouteArgs({
    this.key,
    required this.transaction,
  });

  final _i27.Key? key;

  final _i32.MerchantTransaction transaction;

  @override
  String toString() {
    return 'InstapayRouteArgs{key: $key, transaction: $transaction}';
  }
}

/// generated route for
/// [_i10.KasipreneurScreen]
class KasipreneurRoute extends _i26.PageRouteInfo<void> {
  const KasipreneurRoute({List<_i26.PageRouteInfo>? children})
      : super(
          KasipreneurRoute.name,
          initialChildren: children,
        );

  static const String name = 'KasipreneurRoute';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i11.KasipreneurViewScreen]
class KasipreneurViewRoute extends _i26.PageRouteInfo<void> {
  const KasipreneurViewRoute({List<_i26.PageRouteInfo>? children})
      : super(
          KasipreneurViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'KasipreneurViewRoute';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i12.MediaFilePreviewUploaderScreen]
class MediaFilePreviewUploaderRoute extends _i26.PageRouteInfo<void> {
  const MediaFilePreviewUploaderRoute({List<_i26.PageRouteInfo>? children})
      : super(
          MediaFilePreviewUploaderRoute.name,
          initialChildren: children,
        );

  static const String name = 'MediaFilePreviewUploaderRoute';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i13.OrderTrackingScreen]
class OrderTrackingRoute extends _i26.PageRouteInfo<OrderTrackingRouteArgs> {
  OrderTrackingRoute({
    _i27.Key? key,
    required _i33.Order order,
    required _i33.OrderEditPrivilage privilage,
    List<_i26.PageRouteInfo>? children,
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

  static const _i26.PageInfo<OrderTrackingRouteArgs> page =
      _i26.PageInfo<OrderTrackingRouteArgs>(name);
}

class OrderTrackingRouteArgs {
  const OrderTrackingRouteArgs({
    this.key,
    required this.order,
    required this.privilage,
  });

  final _i27.Key? key;

  final _i33.Order order;

  final _i33.OrderEditPrivilage privilage;

  @override
  String toString() {
    return 'OrderTrackingRouteArgs{key: $key, order: $order, privilage: $privilage}';
  }
}

/// generated route for
/// [_i14.OzowScreen]
class OzowRoute extends _i26.PageRouteInfo<OzowRouteArgs> {
  OzowRoute({
    _i27.Key? key,
    required int reference,
    required double amount,
    required String type,
    required String bankRef,
    List<_i26.PageRouteInfo>? children,
  }) : super(
          OzowRoute.name,
          args: OzowRouteArgs(
            key: key,
            reference: reference,
            amount: amount,
            type: type,
            bankRef: bankRef,
          ),
          initialChildren: children,
        );

  static const String name = 'OzowRoute';

  static const _i26.PageInfo<OzowRouteArgs> page =
      _i26.PageInfo<OzowRouteArgs>(name);
}

class OzowRouteArgs {
  const OzowRouteArgs({
    this.key,
    required this.reference,
    required this.amount,
    required this.type,
    required this.bankRef,
  });

  final _i27.Key? key;

  final int reference;

  final double amount;

  final String type;

  final String bankRef;

  @override
  String toString() {
    return 'OzowRouteArgs{key: $key, reference: $reference, amount: $amount, type: $type, bankRef: $bankRef}';
  }
}

/// generated route for
/// [_i15.PartnerAppScreen]
class PartnerAppRoute extends _i26.PageRouteInfo<PartnerAppRouteArgs> {
  PartnerAppRoute({
    _i27.Key? key,
    required _i34.Partner partner,
    List<_i26.PageRouteInfo>? children,
  }) : super(
          PartnerAppRoute.name,
          args: PartnerAppRouteArgs(
            key: key,
            partner: partner,
          ),
          initialChildren: children,
        );

  static const String name = 'PartnerAppRoute';

  static const _i26.PageInfo<PartnerAppRouteArgs> page =
      _i26.PageInfo<PartnerAppRouteArgs>(name);
}

class PartnerAppRouteArgs {
  const PartnerAppRouteArgs({
    this.key,
    required this.partner,
  });

  final _i27.Key? key;

  final _i34.Partner partner;

  @override
  String toString() {
    return 'PartnerAppRouteArgs{key: $key, partner: $partner}';
  }
}

/// generated route for
/// [_i16.ReferralsView]
class ReferralsView extends _i26.PageRouteInfo<void> {
  const ReferralsView({List<_i26.PageRouteInfo>? children})
      : super(
          ReferralsView.name,
          initialChildren: children,
        );

  static const String name = 'ReferralsView';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i17.RegisterScreen]
class RegisterRoute extends _i26.PageRouteInfo<void> {
  const RegisterRoute({List<_i26.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i18.ResetPasswordScreen]
class ResetPasswordRoute extends _i26.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i26.PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i19.ShopOverviewScreen]
class ShopOverviewRoute extends _i26.PageRouteInfo<void> {
  const ShopOverviewRoute({List<_i26.PageRouteInfo>? children})
      : super(
          ShopOverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShopOverviewRoute';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i20.SignInScreen]
class SignInRoute extends _i26.PageRouteInfo<void> {
  const SignInRoute({List<_i26.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i21.StartUpScreen]
class StartUpRoute extends _i26.PageRouteInfo<void> {
  const StartUpRoute({List<_i26.PageRouteInfo>? children})
      : super(
          StartUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartUpRoute';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i22.TransferScreen]
class TransferRoute extends _i26.PageRouteInfo<TransferRouteArgs> {
  TransferRoute({
    _i27.Key? key,
    required _i35.Wallet wallet,
    List<_i26.PageRouteInfo>? children,
  }) : super(
          TransferRoute.name,
          args: TransferRouteArgs(
            key: key,
            wallet: wallet,
          ),
          initialChildren: children,
        );

  static const String name = 'TransferRoute';

  static const _i26.PageInfo<TransferRouteArgs> page =
      _i26.PageInfo<TransferRouteArgs>(name);
}

class TransferRouteArgs {
  const TransferRouteArgs({
    this.key,
    required this.wallet,
  });

  final _i27.Key? key;

  final _i35.Wallet wallet;

  @override
  String toString() {
    return 'TransferRouteArgs{key: $key, wallet: $wallet}';
  }
}

/// generated route for
/// [_i23.VoucherViewScreen]
class VoucherViewRoute extends _i26.PageRouteInfo<VoucherViewRouteArgs> {
  VoucherViewRoute({
    _i27.Key? key,
    required int voucherId,
    List<_i26.PageRouteInfo>? children,
  }) : super(
          VoucherViewRoute.name,
          args: VoucherViewRouteArgs(
            key: key,
            voucherId: voucherId,
          ),
          initialChildren: children,
        );

  static const String name = 'VoucherViewRoute';

  static const _i26.PageInfo<VoucherViewRouteArgs> page =
      _i26.PageInfo<VoucherViewRouteArgs>(name);
}

class VoucherViewRouteArgs {
  const VoucherViewRouteArgs({
    this.key,
    required this.voucherId,
  });

  final _i27.Key? key;

  final int voucherId;

  @override
  String toString() {
    return 'VoucherViewRouteArgs{key: $key, voucherId: $voucherId}';
  }
}

/// generated route for
/// [_i24.WalletViewScreen]
class WalletViewRoute extends _i26.PageRouteInfo<WalletViewRouteArgs> {
  WalletViewRoute({
    _i27.Key? key,
    required _i35.Wallet wallet,
    List<_i26.PageRouteInfo>? children,
  }) : super(
          WalletViewRoute.name,
          args: WalletViewRouteArgs(
            key: key,
            wallet: wallet,
          ),
          initialChildren: children,
        );

  static const String name = 'WalletViewRoute';

  static const _i26.PageInfo<WalletViewRouteArgs> page =
      _i26.PageInfo<WalletViewRouteArgs>(name);
}

class WalletViewRouteArgs {
  const WalletViewRouteArgs({
    this.key,
    required this.wallet,
  });

  final _i27.Key? key;

  final _i35.Wallet wallet;

  @override
  String toString() {
    return 'WalletViewRouteArgs{key: $key, wallet: $wallet}';
  }
}

/// generated route for
/// [_i25.YocoPaymentScreen]
class YocoPaymentRoute extends _i26.PageRouteInfo<YocoPaymentRouteArgs> {
  YocoPaymentRoute({
    _i27.Key? key,
    required int reference,
    required double amount,
    List<_i26.PageRouteInfo>? children,
  }) : super(
          YocoPaymentRoute.name,
          args: YocoPaymentRouteArgs(
            key: key,
            reference: reference,
            amount: amount,
          ),
          initialChildren: children,
        );

  static const String name = 'YocoPaymentRoute';

  static const _i26.PageInfo<YocoPaymentRouteArgs> page =
      _i26.PageInfo<YocoPaymentRouteArgs>(name);
}

class YocoPaymentRouteArgs {
  const YocoPaymentRouteArgs({
    this.key,
    required this.reference,
    required this.amount,
  });

  final _i27.Key? key;

  final int reference;

  final double amount;

  @override
  String toString() {
    return 'YocoPaymentRouteArgs{key: $key, reference: $reference, amount: $amount}';
  }
}
