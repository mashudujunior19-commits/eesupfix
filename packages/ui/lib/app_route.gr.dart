// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i39;
import 'package:data/auth/models/profile.dart' as _i49;
import 'package:data/auth/models/user_role.dart' as _i54;
import 'package:data/eesupools/models/eesupool.dart' as _i46;
import 'package:data/eesupools/models/eesupool_level.dart' as _i44;
import 'package:data/eesupools/models/eesupool_order.dart' as _i47;
import 'package:data/eesupools/models/eesupool_type.dart' as _i45;
import 'package:data/eesupreneur/models/eesupreneur.dart' as _i51;
import 'package:data/finance/models/wallet.dart' as _i55;
import 'package:data/geolocation/models/address.dart' as _i48;
import 'package:data/orders/models/order.dart' as _i52;
import 'package:data/orders/models/order_product.dart' as _i43;
import 'package:data/partners/models/partner.dart' as _i53;
import 'package:data/shopping/models/basket.dart' as _i41;
import 'package:data/shopping/models/category.dart' as _i42;
import 'package:data/surveys/models/survey.dart' as _i56;
import 'package:flutter/material.dart' as _i40;
import 'package:instapay_flutter/data/merchant_transaction.dart' as _i50;
import 'package:ui/src/core/widgets/media_file_uploader.dart' as _i17;
import 'package:ui/src/features/auth/profile/ui/edit_profile_screen.dart'
    as _i13;
import 'package:ui/src/features/auth/register/ui/register_screen.dart' as _i26;
import 'package:ui/src/features/auth/reset_password/reset_password_screen.dart'
    as _i27;
import 'package:ui/src/features/auth/sign_in/ui/sign_in_screen.dart' as _i31;
import 'package:ui/src/features/auth/sign_in/ui/start_up_screen.dart' as _i32;
import 'package:ui/src/features/eesupools/ui/create_eesupool_screen.dart'
    as _i8;
import 'package:ui/src/features/eesupools/ui/eesupool_search_screen.dart'
    as _i10;
import 'package:ui/src/features/eesupools/ui/eesupool_view_screen.dart' as _i11;
import 'package:ui/src/features/eesupools/ui/tabs/orders/ui/eesupool_order_view.dart'
    as _i9;
import 'package:ui/src/features/eesupools/ui/tabs/orders/ui/order_receivers_screen.dart'
    as _i18;
import 'package:ui/src/features/finances/crowdvouchers/ui/voucher_view_screen.dart'
    as _i36;
import 'package:ui/src/features/finances/payments/instapay/instapay_confirm_profile.dart'
    as _i14;
import 'package:ui/src/features/finances/payments/instapay/instapay_screen.dart'
    as _i15;
import 'package:ui/src/features/finances/payments/ozow/ozow_screen.dart'
    as _i21;
import 'package:ui/src/features/finances/payments/yoco/yoco_payment_screen.dart'
    as _i38;
import 'package:ui/src/features/finances/wallets/ui/screens/payout_screen.dart'
    as _i24;
import 'package:ui/src/features/finances/wallets/ui/screens/transfer_screen.dart'
    as _i35;
import 'package:ui/src/features/finances/wallets/ui/screens/wallet_view_screen.dart'
    as _i37;
import 'package:ui/src/features/geolocation/ui/screens/addrese_book_screen.dart'
    as _i1;
import 'package:ui/src/features/geolocation/ui/screens/edit_address_screen.dart'
    as _i12;
import 'package:ui/src/features/kasipreneur/ui/kasipreneur_screen.dart' as _i16;
import 'package:ui/src/features/orders/tracking/ui/order_tracking_screen.dart'
    as _i19;
import 'package:ui/src/features/orders/tracking/ui/review_products_screen.dart'
    as _i29;
import 'package:ui/src/features/overview/ui/overview_screen.dart' as _i20;
import 'package:ui/src/features/partners/ui/partner_apps_screen.dart' as _i22;
import 'package:ui/src/features/partners/ui/partners_screen.dart' as _i23;
import 'package:ui/src/features/settings/ui/settings_screen.dart' as _i30;
import 'package:ui/src/features/shop/baskets/ui/basket_view.dart' as _i2;
import 'package:ui/src/features/shop/baskets/ui/baskets_list.dart' as _i3;
import 'package:ui/src/features/shop/browsing/ui/browse_shop.dart' as _i4;
import 'package:ui/src/features/shop/browsing/ui/category_screen.dart' as _i6;
import 'package:ui/src/features/shop/browsing/ui/product_view_screen.dart'
    as _i25;
import 'package:ui/src/features/shop/cart/ui/cart_screen.dart' as _i5;
import 'package:ui/src/features/shop/checkout/ui/checkout_screen.dart' as _i7;
import 'package:ui/src/features/support/ui/support_screen.dart' as _i33;
import 'package:ui/src/features/surveys/ui/response_screen.dart' as _i28;
import 'package:ui/src/features/surveys/ui/survey_screen.dart' as _i34;

abstract class $AppRouter extends _i39.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i39.PageFactory> pagesMap = {
    AddressBookRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddressBookScreen(),
      );
    },
    BasketView.name: (routeData) {
      final args = routeData.argsAs<BasketViewArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.BasketView(
          key: args.key,
          basket: args.basket,
        ),
      );
    },
    BasketsList.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.BasketsList(),
      );
    },
    BrowseShopRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.BrowseShopScreen(),
      );
    },
    CartRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.CartScreen(),
      );
    },
    CategoryRoute.name: (routeData) {
      final args = routeData.argsAs<CategoryRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.CategoryScreen(
          key: args.key,
          category: args.category,
        ),
      );
    },
    CheckoutRoute.name: (routeData) {
      final args = routeData.argsAs<CheckoutRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.CheckoutScreen(
          key: args.key,
          products: args.products,
          total: args.total,
        ),
      );
    },
    CreateEESUpoolRoute.name: (routeData) {
      final args = routeData.argsAs<CreateEESUpoolRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.CreateEESUpoolScreen(
          key: args.key,
          parentId: args.parentId,
          level: args.level,
          type: args.type,
        ),
      );
    },
    EESUpoolOrderViewRoute.name: (routeData) {
      final args = routeData.argsAs<EESUpoolOrderViewRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.EESUpoolOrderViewScreen(
          key: args.key,
          pool: args.pool,
          order: args.order,
        ),
      );
    },
    EESUpoolSearchRoute.name: (routeData) {
      final args = routeData.argsAs<EESUpoolSearchRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.EESUpoolSearchScreen(
          key: args.key,
          type: args.type,
        ),
      );
    },
    EESUpoolViewRoute.name: (routeData) {
      final args = routeData.argsAs<EESUpoolViewRouteArgs>(
          orElse: () => const EESUpoolViewRouteArgs());
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.EESUpoolViewScreen(
          key: args.key,
          poolId: args.poolId,
          pool: args.pool,
        ),
      );
    },
    EditAddressRoute.name: (routeData) {
      final args = routeData.argsAs<EditAddressRouteArgs>(
          orElse: () => const EditAddressRouteArgs());
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.EditAddressScreen(
          key: args.key,
          address: args.address,
          isPersonal: args.isPersonal,
        ),
      );
    },
    EditProfileRoute.name: (routeData) {
      final args = routeData.argsAs<EditProfileRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.EditProfileScreen(
          key: args.key,
          profile: args.profile,
        ),
      );
    },
    InstapayConfirmDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<InstapayConfirmDetailsRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.InstapayConfirmDetailsScreen(
          key: args.key,
          transaction: args.transaction,
        ),
      );
    },
    InstapayRoute.name: (routeData) {
      final args = routeData.argsAs<InstapayRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.InstapayScreen(
          key: args.key,
          transaction: args.transaction,
        ),
      );
    },
    KasipreneurRoute.name: (routeData) {
      final args = routeData.argsAs<KasipreneurRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.KasipreneurScreen(
          key: args.key,
          eesupreneur: args.eesupreneur,
        ),
      );
    },
    MediaFilePreviewUploaderRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.MediaFilePreviewUploaderScreen(),
      );
    },
    OrderReceiverRoute.name: (routeData) {
      final args = routeData.argsAs<OrderReceiverRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.OrderReceiverScreen(
          key: args.key,
          order: args.order,
          pool: args.pool,
          ids: args.ids,
        ),
      );
    },
    OrderTrackingRoute.name: (routeData) {
      final args = routeData.argsAs<OrderTrackingRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.OrderTrackingScreen(
          key: args.key,
          id: args.id,
          privilage: args.privilage,
        ),
      );
    },
    OverviewRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.OverviewScreen(),
      );
    },
    OzowRoute.name: (routeData) {
      final args = routeData.argsAs<OzowRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i21.OzowScreen(
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
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i22.PartnerAppScreen(
          key: args.key,
          partner: args.partner,
        ),
      );
    },
    PartnerRoute.name: (routeData) {
      final args = routeData.argsAs<PartnerRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i23.PartnerScreen(
          key: args.key,
          role: args.role,
        ),
      );
    },
    PayoutRoute.name: (routeData) {
      final args = routeData.argsAs<PayoutRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i24.PayoutScreen(
          key: args.key,
          wallet: args.wallet,
        ),
      );
    },
    ProductViewRoute.name: (routeData) {
      final args = routeData.argsAs<ProductViewRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.ProductViewScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i26.RegisterScreen(),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i27.ResetPasswordScreen(),
      );
    },
    ResponseRoute.name: (routeData) {
      final args = routeData.argsAs<ResponseRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i28.ResponseScreen(
          key: args.key,
          survey: args.survey,
        ),
      );
    },
    ReviewProductsRoute.name: (routeData) {
      final args = routeData.argsAs<ReviewProductsRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i29.ReviewProductsScreen(
          key: args.key,
          privilage: args.privilage,
          order: args.order,
        ),
      );
    },
    SettingsRoutes.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i30.SettingsScreens(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i31.SignInScreen(),
      );
    },
    StartUpRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i32.StartUpScreen(),
      );
    },
    SupportRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i33.SupportScreen(),
      );
    },
    SurveyRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i34.SurveyScreen(),
      );
    },
    TransferRoute.name: (routeData) {
      final args = routeData.argsAs<TransferRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i35.TransferScreen(
          key: args.key,
          wallet: args.wallet,
        ),
      );
    },
    VoucherViewRoute.name: (routeData) {
      final args = routeData.argsAs<VoucherViewRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i36.VoucherViewScreen(
          key: args.key,
          voucherId: args.voucherId,
        ),
      );
    },
    WalletViewRoute.name: (routeData) {
      final args = routeData.argsAs<WalletViewRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i37.WalletViewScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
    YocoPaymentRoute.name: (routeData) {
      final args = routeData.argsAs<YocoPaymentRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i38.YocoPaymentScreen(
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
class AddressBookRoute extends _i39.PageRouteInfo<void> {
  const AddressBookRoute({List<_i39.PageRouteInfo>? children})
      : super(
          AddressBookRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddressBookRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i2.BasketView]
class BasketView extends _i39.PageRouteInfo<BasketViewArgs> {
  BasketView({
    _i40.Key? key,
    required _i41.Basket basket,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          BasketView.name,
          args: BasketViewArgs(
            key: key,
            basket: basket,
          ),
          initialChildren: children,
        );

  static const String name = 'BasketView';

  static const _i39.PageInfo<BasketViewArgs> page =
      _i39.PageInfo<BasketViewArgs>(name);
}

class BasketViewArgs {
  const BasketViewArgs({
    this.key,
    required this.basket,
  });

  final _i40.Key? key;

  final _i41.Basket basket;

  @override
  String toString() {
    return 'BasketViewArgs{key: $key, basket: $basket}';
  }
}

/// generated route for
/// [_i3.BasketsList]
class BasketsList extends _i39.PageRouteInfo<void> {
  const BasketsList({List<_i39.PageRouteInfo>? children})
      : super(
          BasketsList.name,
          initialChildren: children,
        );

  static const String name = 'BasketsList';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i4.BrowseShopScreen]
class BrowseShopRoute extends _i39.PageRouteInfo<void> {
  const BrowseShopRoute({List<_i39.PageRouteInfo>? children})
      : super(
          BrowseShopRoute.name,
          initialChildren: children,
        );

  static const String name = 'BrowseShopRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i5.CartScreen]
class CartRoute extends _i39.PageRouteInfo<void> {
  const CartRoute({List<_i39.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i6.CategoryScreen]
class CategoryRoute extends _i39.PageRouteInfo<CategoryRouteArgs> {
  CategoryRoute({
    _i40.Key? key,
    required _i42.Category category,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          CategoryRoute.name,
          args: CategoryRouteArgs(
            key: key,
            category: category,
          ),
          initialChildren: children,
        );

  static const String name = 'CategoryRoute';

  static const _i39.PageInfo<CategoryRouteArgs> page =
      _i39.PageInfo<CategoryRouteArgs>(name);
}

class CategoryRouteArgs {
  const CategoryRouteArgs({
    this.key,
    required this.category,
  });

  final _i40.Key? key;

  final _i42.Category category;

  @override
  String toString() {
    return 'CategoryRouteArgs{key: $key, category: $category}';
  }
}

/// generated route for
/// [_i7.CheckoutScreen]
class CheckoutRoute extends _i39.PageRouteInfo<CheckoutRouteArgs> {
  CheckoutRoute({
    _i40.Key? key,
    required List<_i43.OrderProduct> products,
    required double total,
    List<_i39.PageRouteInfo>? children,
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

  static const _i39.PageInfo<CheckoutRouteArgs> page =
      _i39.PageInfo<CheckoutRouteArgs>(name);
}

class CheckoutRouteArgs {
  const CheckoutRouteArgs({
    this.key,
    required this.products,
    required this.total,
  });

  final _i40.Key? key;

  final List<_i43.OrderProduct> products;

  final double total;

  @override
  String toString() {
    return 'CheckoutRouteArgs{key: $key, products: $products, total: $total}';
  }
}

/// generated route for
/// [_i8.CreateEESUpoolScreen]
class CreateEESUpoolRoute extends _i39.PageRouteInfo<CreateEESUpoolRouteArgs> {
  CreateEESUpoolRoute({
    _i40.Key? key,
    int? parentId,
    _i44.EESUpoolLevel? level,
    required _i45.EESUpoolType type,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          CreateEESUpoolRoute.name,
          args: CreateEESUpoolRouteArgs(
            key: key,
            parentId: parentId,
            level: level,
            type: type,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateEESUpoolRoute';

  static const _i39.PageInfo<CreateEESUpoolRouteArgs> page =
      _i39.PageInfo<CreateEESUpoolRouteArgs>(name);
}

class CreateEESUpoolRouteArgs {
  const CreateEESUpoolRouteArgs({
    this.key,
    this.parentId,
    this.level,
    required this.type,
  });

  final _i40.Key? key;

  final int? parentId;

  final _i44.EESUpoolLevel? level;

  final _i45.EESUpoolType type;

  @override
  String toString() {
    return 'CreateEESUpoolRouteArgs{key: $key, parentId: $parentId, level: $level, type: $type}';
  }
}

/// generated route for
/// [_i9.EESUpoolOrderViewScreen]
class EESUpoolOrderViewRoute
    extends _i39.PageRouteInfo<EESUpoolOrderViewRouteArgs> {
  EESUpoolOrderViewRoute({
    _i40.Key? key,
    required _i46.EESUpool pool,
    required _i47.EESUpoolOrder order,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          EESUpoolOrderViewRoute.name,
          args: EESUpoolOrderViewRouteArgs(
            key: key,
            pool: pool,
            order: order,
          ),
          initialChildren: children,
        );

  static const String name = 'EESUpoolOrderViewRoute';

  static const _i39.PageInfo<EESUpoolOrderViewRouteArgs> page =
      _i39.PageInfo<EESUpoolOrderViewRouteArgs>(name);
}

class EESUpoolOrderViewRouteArgs {
  const EESUpoolOrderViewRouteArgs({
    this.key,
    required this.pool,
    required this.order,
  });

  final _i40.Key? key;

  final _i46.EESUpool pool;

  final _i47.EESUpoolOrder order;

  @override
  String toString() {
    return 'EESUpoolOrderViewRouteArgs{key: $key, pool: $pool, order: $order}';
  }
}

/// generated route for
/// [_i10.EESUpoolSearchScreen]
class EESUpoolSearchRoute extends _i39.PageRouteInfo<EESUpoolSearchRouteArgs> {
  EESUpoolSearchRoute({
    _i40.Key? key,
    required _i45.EESUpoolType type,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          EESUpoolSearchRoute.name,
          args: EESUpoolSearchRouteArgs(
            key: key,
            type: type,
          ),
          initialChildren: children,
        );

  static const String name = 'EESUpoolSearchRoute';

  static const _i39.PageInfo<EESUpoolSearchRouteArgs> page =
      _i39.PageInfo<EESUpoolSearchRouteArgs>(name);
}

class EESUpoolSearchRouteArgs {
  const EESUpoolSearchRouteArgs({
    this.key,
    required this.type,
  });

  final _i40.Key? key;

  final _i45.EESUpoolType type;

  @override
  String toString() {
    return 'EESUpoolSearchRouteArgs{key: $key, type: $type}';
  }
}

/// generated route for
/// [_i11.EESUpoolViewScreen]
class EESUpoolViewRoute extends _i39.PageRouteInfo<EESUpoolViewRouteArgs> {
  EESUpoolViewRoute({
    _i40.Key? key,
    int? poolId,
    _i46.EESUpool? pool,
    List<_i39.PageRouteInfo>? children,
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

  static const _i39.PageInfo<EESUpoolViewRouteArgs> page =
      _i39.PageInfo<EESUpoolViewRouteArgs>(name);
}

class EESUpoolViewRouteArgs {
  const EESUpoolViewRouteArgs({
    this.key,
    this.poolId,
    this.pool,
  });

  final _i40.Key? key;

  final int? poolId;

  final _i46.EESUpool? pool;

  @override
  String toString() {
    return 'EESUpoolViewRouteArgs{key: $key, poolId: $poolId, pool: $pool}';
  }
}

/// generated route for
/// [_i12.EditAddressScreen]
class EditAddressRoute extends _i39.PageRouteInfo<EditAddressRouteArgs> {
  EditAddressRoute({
    _i40.Key? key,
    _i48.Address? address,
    bool isPersonal = true,
    List<_i39.PageRouteInfo>? children,
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

  static const _i39.PageInfo<EditAddressRouteArgs> page =
      _i39.PageInfo<EditAddressRouteArgs>(name);
}

class EditAddressRouteArgs {
  const EditAddressRouteArgs({
    this.key,
    this.address,
    this.isPersonal = true,
  });

  final _i40.Key? key;

  final _i48.Address? address;

  final bool isPersonal;

  @override
  String toString() {
    return 'EditAddressRouteArgs{key: $key, address: $address, isPersonal: $isPersonal}';
  }
}

/// generated route for
/// [_i13.EditProfileScreen]
class EditProfileRoute extends _i39.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i40.Key? key,
    required _i49.Profile profile,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          EditProfileRoute.name,
          args: EditProfileRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const _i39.PageInfo<EditProfileRouteArgs> page =
      _i39.PageInfo<EditProfileRouteArgs>(name);
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({
    this.key,
    required this.profile,
  });

  final _i40.Key? key;

  final _i49.Profile profile;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i14.InstapayConfirmDetailsScreen]
class InstapayConfirmDetailsRoute
    extends _i39.PageRouteInfo<InstapayConfirmDetailsRouteArgs> {
  InstapayConfirmDetailsRoute({
    _i40.Key? key,
    required _i50.MerchantTransaction transaction,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          InstapayConfirmDetailsRoute.name,
          args: InstapayConfirmDetailsRouteArgs(
            key: key,
            transaction: transaction,
          ),
          initialChildren: children,
        );

  static const String name = 'InstapayConfirmDetailsRoute';

  static const _i39.PageInfo<InstapayConfirmDetailsRouteArgs> page =
      _i39.PageInfo<InstapayConfirmDetailsRouteArgs>(name);
}

class InstapayConfirmDetailsRouteArgs {
  const InstapayConfirmDetailsRouteArgs({
    this.key,
    required this.transaction,
  });

  final _i40.Key? key;

  final _i50.MerchantTransaction transaction;

  @override
  String toString() {
    return 'InstapayConfirmDetailsRouteArgs{key: $key, transaction: $transaction}';
  }
}

/// generated route for
/// [_i15.InstapayScreen]
class InstapayRoute extends _i39.PageRouteInfo<InstapayRouteArgs> {
  InstapayRoute({
    _i40.Key? key,
    required _i50.MerchantTransaction transaction,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          InstapayRoute.name,
          args: InstapayRouteArgs(
            key: key,
            transaction: transaction,
          ),
          initialChildren: children,
        );

  static const String name = 'InstapayRoute';

  static const _i39.PageInfo<InstapayRouteArgs> page =
      _i39.PageInfo<InstapayRouteArgs>(name);
}

class InstapayRouteArgs {
  const InstapayRouteArgs({
    this.key,
    required this.transaction,
  });

  final _i40.Key? key;

  final _i50.MerchantTransaction transaction;

  @override
  String toString() {
    return 'InstapayRouteArgs{key: $key, transaction: $transaction}';
  }
}

/// generated route for
/// [_i16.KasipreneurScreen]
class KasipreneurRoute extends _i39.PageRouteInfo<KasipreneurRouteArgs> {
  KasipreneurRoute({
    _i40.Key? key,
    required _i51.EESUpreneur eesupreneur,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          KasipreneurRoute.name,
          args: KasipreneurRouteArgs(
            key: key,
            eesupreneur: eesupreneur,
          ),
          initialChildren: children,
        );

  static const String name = 'KasipreneurRoute';

  static const _i39.PageInfo<KasipreneurRouteArgs> page =
      _i39.PageInfo<KasipreneurRouteArgs>(name);
}

class KasipreneurRouteArgs {
  const KasipreneurRouteArgs({
    this.key,
    required this.eesupreneur,
  });

  final _i40.Key? key;

  final _i51.EESUpreneur eesupreneur;

  @override
  String toString() {
    return 'KasipreneurRouteArgs{key: $key, eesupreneur: $eesupreneur}';
  }
}

/// generated route for
/// [_i17.MediaFilePreviewUploaderScreen]
class MediaFilePreviewUploaderRoute extends _i39.PageRouteInfo<void> {
  const MediaFilePreviewUploaderRoute({List<_i39.PageRouteInfo>? children})
      : super(
          MediaFilePreviewUploaderRoute.name,
          initialChildren: children,
        );

  static const String name = 'MediaFilePreviewUploaderRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i18.OrderReceiverScreen]
class OrderReceiverRoute extends _i39.PageRouteInfo<OrderReceiverRouteArgs> {
  OrderReceiverRoute({
    _i40.Key? key,
    required _i47.EESUpoolOrder order,
    required _i46.EESUpool pool,
    required List<String> ids,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          OrderReceiverRoute.name,
          args: OrderReceiverRouteArgs(
            key: key,
            order: order,
            pool: pool,
            ids: ids,
          ),
          initialChildren: children,
        );

  static const String name = 'OrderReceiverRoute';

  static const _i39.PageInfo<OrderReceiverRouteArgs> page =
      _i39.PageInfo<OrderReceiverRouteArgs>(name);
}

class OrderReceiverRouteArgs {
  const OrderReceiverRouteArgs({
    this.key,
    required this.order,
    required this.pool,
    required this.ids,
  });

  final _i40.Key? key;

  final _i47.EESUpoolOrder order;

  final _i46.EESUpool pool;

  final List<String> ids;

  @override
  String toString() {
    return 'OrderReceiverRouteArgs{key: $key, order: $order, pool: $pool, ids: $ids}';
  }
}

/// generated route for
/// [_i19.OrderTrackingScreen]
class OrderTrackingRoute extends _i39.PageRouteInfo<OrderTrackingRouteArgs> {
  OrderTrackingRoute({
    _i40.Key? key,
    required int id,
    required _i52.OrderEditPrivilage privilage,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          OrderTrackingRoute.name,
          args: OrderTrackingRouteArgs(
            key: key,
            id: id,
            privilage: privilage,
          ),
          initialChildren: children,
        );

  static const String name = 'OrderTrackingRoute';

  static const _i39.PageInfo<OrderTrackingRouteArgs> page =
      _i39.PageInfo<OrderTrackingRouteArgs>(name);
}

class OrderTrackingRouteArgs {
  const OrderTrackingRouteArgs({
    this.key,
    required this.id,
    required this.privilage,
  });

  final _i40.Key? key;

  final int id;

  final _i52.OrderEditPrivilage privilage;

  @override
  String toString() {
    return 'OrderTrackingRouteArgs{key: $key, id: $id, privilage: $privilage}';
  }
}

/// generated route for
/// [_i20.OverviewScreen]
class OverviewRoute extends _i39.PageRouteInfo<void> {
  const OverviewRoute({List<_i39.PageRouteInfo>? children})
      : super(
          OverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'OverviewRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i21.OzowScreen]
class OzowRoute extends _i39.PageRouteInfo<OzowRouteArgs> {
  OzowRoute({
    _i40.Key? key,
    required int reference,
    required double amount,
    required String type,
    required String bankRef,
    List<_i39.PageRouteInfo>? children,
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

  static const _i39.PageInfo<OzowRouteArgs> page =
      _i39.PageInfo<OzowRouteArgs>(name);
}

class OzowRouteArgs {
  const OzowRouteArgs({
    this.key,
    required this.reference,
    required this.amount,
    required this.type,
    required this.bankRef,
  });

  final _i40.Key? key;

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
/// [_i22.PartnerAppScreen]
class PartnerAppRoute extends _i39.PageRouteInfo<PartnerAppRouteArgs> {
  PartnerAppRoute({
    _i40.Key? key,
    required _i53.Partner partner,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          PartnerAppRoute.name,
          args: PartnerAppRouteArgs(
            key: key,
            partner: partner,
          ),
          initialChildren: children,
        );

  static const String name = 'PartnerAppRoute';

  static const _i39.PageInfo<PartnerAppRouteArgs> page =
      _i39.PageInfo<PartnerAppRouteArgs>(name);
}

class PartnerAppRouteArgs {
  const PartnerAppRouteArgs({
    this.key,
    required this.partner,
  });

  final _i40.Key? key;

  final _i53.Partner partner;

  @override
  String toString() {
    return 'PartnerAppRouteArgs{key: $key, partner: $partner}';
  }
}

/// generated route for
/// [_i23.PartnerScreen]
class PartnerRoute extends _i39.PageRouteInfo<PartnerRouteArgs> {
  PartnerRoute({
    _i40.Key? key,
    required _i54.UserRole role,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          PartnerRoute.name,
          args: PartnerRouteArgs(
            key: key,
            role: role,
          ),
          initialChildren: children,
        );

  static const String name = 'PartnerRoute';

  static const _i39.PageInfo<PartnerRouteArgs> page =
      _i39.PageInfo<PartnerRouteArgs>(name);
}

class PartnerRouteArgs {
  const PartnerRouteArgs({
    this.key,
    required this.role,
  });

  final _i40.Key? key;

  final _i54.UserRole role;

  @override
  String toString() {
    return 'PartnerRouteArgs{key: $key, role: $role}';
  }
}

/// generated route for
/// [_i24.PayoutScreen]
class PayoutRoute extends _i39.PageRouteInfo<PayoutRouteArgs> {
  PayoutRoute({
    _i40.Key? key,
    required _i55.Wallet wallet,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          PayoutRoute.name,
          args: PayoutRouteArgs(
            key: key,
            wallet: wallet,
          ),
          initialChildren: children,
        );

  static const String name = 'PayoutRoute';

  static const _i39.PageInfo<PayoutRouteArgs> page =
      _i39.PageInfo<PayoutRouteArgs>(name);
}

class PayoutRouteArgs {
  const PayoutRouteArgs({
    this.key,
    required this.wallet,
  });

  final _i40.Key? key;

  final _i55.Wallet wallet;

  @override
  String toString() {
    return 'PayoutRouteArgs{key: $key, wallet: $wallet}';
  }
}

/// generated route for
/// [_i25.ProductViewScreen]
class ProductViewRoute extends _i39.PageRouteInfo<ProductViewRouteArgs> {
  ProductViewRoute({
    _i40.Key? key,
    required int id,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          ProductViewRoute.name,
          args: ProductViewRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductViewRoute';

  static const _i39.PageInfo<ProductViewRouteArgs> page =
      _i39.PageInfo<ProductViewRouteArgs>(name);
}

class ProductViewRouteArgs {
  const ProductViewRouteArgs({
    this.key,
    required this.id,
  });

  final _i40.Key? key;

  final int id;

  @override
  String toString() {
    return 'ProductViewRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i26.RegisterScreen]
class RegisterRoute extends _i39.PageRouteInfo<void> {
  const RegisterRoute({List<_i39.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i27.ResetPasswordScreen]
class ResetPasswordRoute extends _i39.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i39.PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i28.ResponseScreen]
class ResponseRoute extends _i39.PageRouteInfo<ResponseRouteArgs> {
  ResponseRoute({
    _i40.Key? key,
    required _i56.Survey survey,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          ResponseRoute.name,
          args: ResponseRouteArgs(
            key: key,
            survey: survey,
          ),
          initialChildren: children,
        );

  static const String name = 'ResponseRoute';

  static const _i39.PageInfo<ResponseRouteArgs> page =
      _i39.PageInfo<ResponseRouteArgs>(name);
}

class ResponseRouteArgs {
  const ResponseRouteArgs({
    this.key,
    required this.survey,
  });

  final _i40.Key? key;

  final _i56.Survey survey;

  @override
  String toString() {
    return 'ResponseRouteArgs{key: $key, survey: $survey}';
  }
}

/// generated route for
/// [_i29.ReviewProductsScreen]
class ReviewProductsRoute extends _i39.PageRouteInfo<ReviewProductsRouteArgs> {
  ReviewProductsRoute({
    _i40.Key? key,
    required _i52.OrderEditPrivilage privilage,
    required _i52.Order order,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          ReviewProductsRoute.name,
          args: ReviewProductsRouteArgs(
            key: key,
            privilage: privilage,
            order: order,
          ),
          initialChildren: children,
        );

  static const String name = 'ReviewProductsRoute';

  static const _i39.PageInfo<ReviewProductsRouteArgs> page =
      _i39.PageInfo<ReviewProductsRouteArgs>(name);
}

class ReviewProductsRouteArgs {
  const ReviewProductsRouteArgs({
    this.key,
    required this.privilage,
    required this.order,
  });

  final _i40.Key? key;

  final _i52.OrderEditPrivilage privilage;

  final _i52.Order order;

  @override
  String toString() {
    return 'ReviewProductsRouteArgs{key: $key, privilage: $privilage, order: $order}';
  }
}

/// generated route for
/// [_i30.SettingsScreens]
class SettingsRoutes extends _i39.PageRouteInfo<void> {
  const SettingsRoutes({List<_i39.PageRouteInfo>? children})
      : super(
          SettingsRoutes.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoutes';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i31.SignInScreen]
class SignInRoute extends _i39.PageRouteInfo<void> {
  const SignInRoute({List<_i39.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i32.StartUpScreen]
class StartUpRoute extends _i39.PageRouteInfo<void> {
  const StartUpRoute({List<_i39.PageRouteInfo>? children})
      : super(
          StartUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartUpRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i33.SupportScreen]
class SupportRoute extends _i39.PageRouteInfo<void> {
  const SupportRoute({List<_i39.PageRouteInfo>? children})
      : super(
          SupportRoute.name,
          initialChildren: children,
        );

  static const String name = 'SupportRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i34.SurveyScreen]
class SurveyRoute extends _i39.PageRouteInfo<void> {
  const SurveyRoute({List<_i39.PageRouteInfo>? children})
      : super(
          SurveyRoute.name,
          initialChildren: children,
        );

  static const String name = 'SurveyRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i35.TransferScreen]
class TransferRoute extends _i39.PageRouteInfo<TransferRouteArgs> {
  TransferRoute({
    _i40.Key? key,
    required _i55.Wallet wallet,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          TransferRoute.name,
          args: TransferRouteArgs(
            key: key,
            wallet: wallet,
          ),
          initialChildren: children,
        );

  static const String name = 'TransferRoute';

  static const _i39.PageInfo<TransferRouteArgs> page =
      _i39.PageInfo<TransferRouteArgs>(name);
}

class TransferRouteArgs {
  const TransferRouteArgs({
    this.key,
    required this.wallet,
  });

  final _i40.Key? key;

  final _i55.Wallet wallet;

  @override
  String toString() {
    return 'TransferRouteArgs{key: $key, wallet: $wallet}';
  }
}

/// generated route for
/// [_i36.VoucherViewScreen]
class VoucherViewRoute extends _i39.PageRouteInfo<VoucherViewRouteArgs> {
  VoucherViewRoute({
    _i40.Key? key,
    required int voucherId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          VoucherViewRoute.name,
          args: VoucherViewRouteArgs(
            key: key,
            voucherId: voucherId,
          ),
          initialChildren: children,
        );

  static const String name = 'VoucherViewRoute';

  static const _i39.PageInfo<VoucherViewRouteArgs> page =
      _i39.PageInfo<VoucherViewRouteArgs>(name);
}

class VoucherViewRouteArgs {
  const VoucherViewRouteArgs({
    this.key,
    required this.voucherId,
  });

  final _i40.Key? key;

  final int voucherId;

  @override
  String toString() {
    return 'VoucherViewRouteArgs{key: $key, voucherId: $voucherId}';
  }
}

/// generated route for
/// [_i37.WalletViewScreen]
class WalletViewRoute extends _i39.PageRouteInfo<WalletViewRouteArgs> {
  WalletViewRoute({
    _i40.Key? key,
    required int id,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          WalletViewRoute.name,
          args: WalletViewRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'WalletViewRoute';

  static const _i39.PageInfo<WalletViewRouteArgs> page =
      _i39.PageInfo<WalletViewRouteArgs>(name);
}

class WalletViewRouteArgs {
  const WalletViewRouteArgs({
    this.key,
    required this.id,
  });

  final _i40.Key? key;

  final int id;

  @override
  String toString() {
    return 'WalletViewRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i38.YocoPaymentScreen]
class YocoPaymentRoute extends _i39.PageRouteInfo<YocoPaymentRouteArgs> {
  YocoPaymentRoute({
    _i40.Key? key,
    required int reference,
    required double amount,
    List<_i39.PageRouteInfo>? children,
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

  static const _i39.PageInfo<YocoPaymentRouteArgs> page =
      _i39.PageInfo<YocoPaymentRouteArgs>(name);
}

class YocoPaymentRouteArgs {
  const YocoPaymentRouteArgs({
    this.key,
    required this.reference,
    required this.amount,
  });

  final _i40.Key? key;

  final int reference;

  final double amount;

  @override
  String toString() {
    return 'YocoPaymentRouteArgs{key: $key, reference: $reference, amount: $amount}';
  }
}
