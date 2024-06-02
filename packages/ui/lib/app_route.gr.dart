// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i43;
import 'package:data/auth/models/profile.dart' as _i55;
import 'package:data/auth/models/user_role.dart' as _i60;
import 'package:data/eesupools/models/eesupool.dart' as _i50;
import 'package:data/eesupools/models/eesupool_issue.dart' as _i57;
import 'package:data/eesupools/models/eesupool_level.dart' as _i48;
import 'package:data/eesupools/models/eesupool_order.dart' as _i51;
import 'package:data/eesupools/models/eesupool_type.dart' as _i49;
import 'package:data/eesupreneur/models/eesupreneur.dart' as _i58;
import 'package:data/finance/models/wallet.dart' as _i61;
import 'package:data/geolocation/models/address.dart' as _i52;
import 'package:data/orders/models/order.dart' as _i59;
import 'package:data/orders/models/order_product.dart' as _i47;
import 'package:data/partners/models/partner.dart' as _i54;
import 'package:data/partners/models/partner_application.dart' as _i53;
import 'package:data/shopping/models/basket.dart' as _i45;
import 'package:data/shopping/models/category.dart' as _i46;
import 'package:data/surveys/models/survey.dart' as _i62;
import 'package:flutter/material.dart' as _i44;
import 'package:instapay_flutter/data/merchant_transaction.dart' as _i56;
import 'package:ui/src/core/widgets/media_file_uploader.dart' as _i19;
import 'package:ui/src/views/auth/profile/ui/edit_profile_screen.dart' as _i14;
import 'package:ui/src/views/auth/register/ui/register_screen.dart' as _i29;
import 'package:ui/src/views/auth/reset_password/reset_password_screen.dart'
    as _i30;
import 'package:ui/src/views/auth/sign_in/ui/sign_in_screen.dart' as _i34;
import 'package:ui/src/views/auth/sign_in/ui/start_up_screen.dart' as _i35;
import 'package:ui/src/views/eesupools/ui/create_eesupool_screen.dart' as _i8;
import 'package:ui/src/views/eesupools/ui/eesupool_search_screen.dart' as _i10;
import 'package:ui/src/views/eesupools/ui/eesupool_view_screen.dart' as _i11;
import 'package:ui/src/views/eesupools/ui/tabs/issues/ui/issue_view_screen.dart'
    as _i17;
import 'package:ui/src/views/eesupools/ui/tabs/orders/ui/order_receivers_screen.dart'
    as _i20;
import 'package:ui/src/views/eesupools/ui/tabs/orders/ui/order_view.dart'
    as _i9;
import 'package:ui/src/views/finances/crowdvouchers/ui/voucher_view_screen.dart'
    as _i40;
import 'package:ui/src/views/finances/payments/instapay/instapay_confirm_profile.dart'
    as _i15;
import 'package:ui/src/views/finances/payments/instapay/instapay_screen.dart'
    as _i16;
import 'package:ui/src/views/finances/payments/ozow/ozow_screen.dart' as _i23;
import 'package:ui/src/views/finances/payments/yoco/yoco_payment_screen.dart'
    as _i42;
import 'package:ui/src/views/finances/wallets/ui/screens/payout_screen.dart'
    as _i26;
import 'package:ui/src/views/finances/wallets/ui/screens/transfer_screen.dart'
    as _i39;
import 'package:ui/src/views/finances/wallets/ui/screens/wallet_view_screen.dart'
    as _i41;
import 'package:ui/src/views/geolocation/ui/screens/addrese_book_screen.dart'
    as _i1;
import 'package:ui/src/views/geolocation/ui/screens/edit_address_screen.dart'
    as _i12;
import 'package:ui/src/views/kasipreneur/ui/kasipreneur_screen.dart' as _i18;
import 'package:ui/src/views/menu/terms_of_services_screen.dart' as _i38;
import 'package:ui/src/views/orders/tracking/ui/order_tracking_screen.dart'
    as _i21;
import 'package:ui/src/views/orders/tracking/ui/review_products_screen.dart'
    as _i32;
import 'package:ui/src/views/overview/ui/overview_screen.dart' as _i22;
import 'package:ui/src/views/partners/ui/edit_application.dart' as _i13;
import 'package:ui/src/views/partners/ui/partner_apps_screen.dart' as _i24;
import 'package:ui/src/views/partners/ui/partners_screen.dart' as _i25;
import 'package:ui/src/views/settings/ui/settings_screen.dart' as _i33;
import 'package:ui/src/views/shop/baskets/ui/basket_view.dart' as _i2;
import 'package:ui/src/views/shop/baskets/ui/baskets_list.dart' as _i3;
import 'package:ui/src/views/shop/browsing/ui/browse_shop.dart' as _i4;
import 'package:ui/src/views/shop/browsing/ui/category_screen.dart' as _i6;
import 'package:ui/src/views/shop/browsing/ui/product_view_screen.dart' as _i28;
import 'package:ui/src/views/shop/cart/ui/cart_screen.dart' as _i5;
import 'package:ui/src/views/shop/checkout/ui/checkout_screen.dart' as _i7;
import 'package:ui/src/views/shop/product_request/product_request_screen.dart'
    as _i27;
import 'package:ui/src/views/support/ui/support_screen.dart' as _i36;
import 'package:ui/src/views/surveys/ui/response_screen.dart' as _i31;
import 'package:ui/src/views/surveys/ui/survey_screen.dart' as _i37;

abstract class $AppRouter extends _i43.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i43.PageFactory> pagesMap = {
    AddressBookRoute.name: (routeData) {
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddressBookScreen(),
      );
    },
    BasketViewRoute.name: (routeData) {
      final args = routeData.argsAs<BasketViewRouteArgs>();
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.BasketViewScreen(
          key: args.key,
          basket: args.basket,
        ),
      );
    },
    BasketsListRoute.name: (routeData) {
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.BasketsListScreen(),
      );
    },
    BrowseShopRoute.name: (routeData) {
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.BrowseShopScreen(),
      );
    },
    CartRoute.name: (routeData) {
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.CartScreen(),
      );
    },
    CategoryRoute.name: (routeData) {
      final args = routeData.argsAs<CategoryRouteArgs>();
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.CategoryScreen(
          key: args.key,
          category: args.category,
        ),
      );
    },
    CheckoutRoute.name: (routeData) {
      final args = routeData.argsAs<CheckoutRouteArgs>();
      return _i43.AutoRoutePage<dynamic>(
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
      return _i43.AutoRoutePage<dynamic>(
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
      return _i43.AutoRoutePage<dynamic>(
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
      return _i43.AutoRoutePage<dynamic>(
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
      return _i43.AutoRoutePage<dynamic>(
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
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.EditAddressScreen(
          key: args.key,
          address: args.address,
          isPersonal: args.isPersonal,
        ),
      );
    },
    EditApplicationRoute.name: (routeData) {
      final args = routeData.argsAs<EditApplicationRouteArgs>();
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.EditApplicationScreen(
          key: args.key,
          app: args.app,
          partner: args.partner,
        ),
      );
    },
    EditProfileRoute.name: (routeData) {
      final args = routeData.argsAs<EditProfileRouteArgs>();
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.EditProfileScreen(
          key: args.key,
          profile: args.profile,
        ),
      );
    },
    InstapayConfirmDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<InstapayConfirmDetailsRouteArgs>();
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.InstapayConfirmDetailsScreen(
          key: args.key,
          transaction: args.transaction,
        ),
      );
    },
    InstapayRoute.name: (routeData) {
      final args = routeData.argsAs<InstapayRouteArgs>();
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.InstapayScreen(
          key: args.key,
          transaction: args.transaction,
        ),
      );
    },
    IssueViewRoute.name: (routeData) {
      final args = routeData.argsAs<IssueViewRouteArgs>();
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.IssueViewScreen(
          key: args.key,
          pool: args.pool,
          issue: args.issue,
        ),
      );
    },
    KasipreneurRoute.name: (routeData) {
      final args = routeData.argsAs<KasipreneurRouteArgs>();
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.KasipreneurScreen(
          key: args.key,
          eesupreneur: args.eesupreneur,
        ),
      );
    },
    MediaFilePreviewUploaderRoute.name: (routeData) {
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.MediaFilePreviewUploaderScreen(),
      );
    },
    OrderReceiverRoute.name: (routeData) {
      final args = routeData.argsAs<OrderReceiverRouteArgs>();
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i20.OrderReceiverScreen(
          key: args.key,
          order: args.order,
          pool: args.pool,
          ids: args.ids,
        ),
      );
    },
    OrderTrackingRoute.name: (routeData) {
      final args = routeData.argsAs<OrderTrackingRouteArgs>();
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i21.OrderTrackingScreen(
          key: args.key,
          id: args.id,
          privilage: args.privilage,
        ),
      );
    },
    OverviewRoute.name: (routeData) {
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.OverviewScreen(),
      );
    },
    OzowRoute.name: (routeData) {
      final args = routeData.argsAs<OzowRouteArgs>();
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i23.OzowScreen(
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
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i24.PartnerAppScreen(
          key: args.key,
          partner: args.partner,
        ),
      );
    },
    PartnerRoute.name: (routeData) {
      final args = routeData.argsAs<PartnerRouteArgs>();
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.PartnerScreen(
          key: args.key,
          role: args.role,
        ),
      );
    },
    PayoutRoute.name: (routeData) {
      final args = routeData.argsAs<PayoutRouteArgs>();
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i26.PayoutScreen(
          key: args.key,
          wallet: args.wallet,
        ),
      );
    },
    ProductRequestRoute.name: (routeData) {
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i27.ProductRequestScreen(),
      );
    },
    ProductViewRoute.name: (routeData) {
      final args = routeData.argsAs<ProductViewRouteArgs>();
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i28.ProductViewScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i29.RegisterScreen(),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i30.ResetPasswordScreen(),
      );
    },
    ResponseRoute.name: (routeData) {
      final args = routeData.argsAs<ResponseRouteArgs>();
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i31.ResponseScreen(
          key: args.key,
          survey: args.survey,
        ),
      );
    },
    ReviewProductsRoute.name: (routeData) {
      final args = routeData.argsAs<ReviewProductsRouteArgs>();
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i32.ReviewProductsScreen(
          key: args.key,
          privilage: args.privilage,
          order: args.order,
        ),
      );
    },
    SettingsRoutes.name: (routeData) {
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i33.SettingsScreens(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i34.SignInScreen(),
      );
    },
    StartUpRoute.name: (routeData) {
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i35.StartUpScreen(),
      );
    },
    SupportRoute.name: (routeData) {
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i36.SupportScreen(),
      );
    },
    SurveyRoute.name: (routeData) {
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i37.SurveyScreen(),
      );
    },
    TermsOfServiceRoute.name: (routeData) {
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i38.TermsOfServiceScreen(),
      );
    },
    TransferRoute.name: (routeData) {
      final args = routeData.argsAs<TransferRouteArgs>();
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i39.TransferScreen(
          key: args.key,
          wallet: args.wallet,
        ),
      );
    },
    VoucherViewRoute.name: (routeData) {
      final args = routeData.argsAs<VoucherViewRouteArgs>();
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i40.VoucherViewScreen(
          key: args.key,
          voucherId: args.voucherId,
        ),
      );
    },
    WalletViewRoute.name: (routeData) {
      final args = routeData.argsAs<WalletViewRouteArgs>();
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i41.WalletViewScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
    YocoPaymentRoute.name: (routeData) {
      final args = routeData.argsAs<YocoPaymentRouteArgs>();
      return _i43.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i42.YocoPaymentScreen(
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
class AddressBookRoute extends _i43.PageRouteInfo<void> {
  const AddressBookRoute({List<_i43.PageRouteInfo>? children})
      : super(
          AddressBookRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddressBookRoute';

  static const _i43.PageInfo<void> page = _i43.PageInfo<void>(name);
}

/// generated route for
/// [_i2.BasketViewScreen]
class BasketViewRoute extends _i43.PageRouteInfo<BasketViewRouteArgs> {
  BasketViewRoute({
    _i44.Key? key,
    required _i45.Basket basket,
    List<_i43.PageRouteInfo>? children,
  }) : super(
          BasketViewRoute.name,
          args: BasketViewRouteArgs(
            key: key,
            basket: basket,
          ),
          initialChildren: children,
        );

  static const String name = 'BasketViewRoute';

  static const _i43.PageInfo<BasketViewRouteArgs> page =
      _i43.PageInfo<BasketViewRouteArgs>(name);
}

class BasketViewRouteArgs {
  const BasketViewRouteArgs({
    this.key,
    required this.basket,
  });

  final _i44.Key? key;

  final _i45.Basket basket;

  @override
  String toString() {
    return 'BasketViewRouteArgs{key: $key, basket: $basket}';
  }
}

/// generated route for
/// [_i3.BasketsListScreen]
class BasketsListRoute extends _i43.PageRouteInfo<void> {
  const BasketsListRoute({List<_i43.PageRouteInfo>? children})
      : super(
          BasketsListRoute.name,
          initialChildren: children,
        );

  static const String name = 'BasketsListRoute';

  static const _i43.PageInfo<void> page = _i43.PageInfo<void>(name);
}

/// generated route for
/// [_i4.BrowseShopScreen]
class BrowseShopRoute extends _i43.PageRouteInfo<void> {
  const BrowseShopRoute({List<_i43.PageRouteInfo>? children})
      : super(
          BrowseShopRoute.name,
          initialChildren: children,
        );

  static const String name = 'BrowseShopRoute';

  static const _i43.PageInfo<void> page = _i43.PageInfo<void>(name);
}

/// generated route for
/// [_i5.CartScreen]
class CartRoute extends _i43.PageRouteInfo<void> {
  const CartRoute({List<_i43.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static const _i43.PageInfo<void> page = _i43.PageInfo<void>(name);
}

/// generated route for
/// [_i6.CategoryScreen]
class CategoryRoute extends _i43.PageRouteInfo<CategoryRouteArgs> {
  CategoryRoute({
    _i44.Key? key,
    required _i46.Category category,
    List<_i43.PageRouteInfo>? children,
  }) : super(
          CategoryRoute.name,
          args: CategoryRouteArgs(
            key: key,
            category: category,
          ),
          initialChildren: children,
        );

  static const String name = 'CategoryRoute';

  static const _i43.PageInfo<CategoryRouteArgs> page =
      _i43.PageInfo<CategoryRouteArgs>(name);
}

class CategoryRouteArgs {
  const CategoryRouteArgs({
    this.key,
    required this.category,
  });

  final _i44.Key? key;

  final _i46.Category category;

  @override
  String toString() {
    return 'CategoryRouteArgs{key: $key, category: $category}';
  }
}

/// generated route for
/// [_i7.CheckoutScreen]
class CheckoutRoute extends _i43.PageRouteInfo<CheckoutRouteArgs> {
  CheckoutRoute({
    _i44.Key? key,
    required List<_i47.OrderProduct> products,
    required double total,
    List<_i43.PageRouteInfo>? children,
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

  static const _i43.PageInfo<CheckoutRouteArgs> page =
      _i43.PageInfo<CheckoutRouteArgs>(name);
}

class CheckoutRouteArgs {
  const CheckoutRouteArgs({
    this.key,
    required this.products,
    required this.total,
  });

  final _i44.Key? key;

  final List<_i47.OrderProduct> products;

  final double total;

  @override
  String toString() {
    return 'CheckoutRouteArgs{key: $key, products: $products, total: $total}';
  }
}

/// generated route for
/// [_i8.CreateEESUpoolScreen]
class CreateEESUpoolRoute extends _i43.PageRouteInfo<CreateEESUpoolRouteArgs> {
  CreateEESUpoolRoute({
    _i44.Key? key,
    int? parentId,
    _i48.EESUpoolLevel? level,
    required _i49.EESUpoolType type,
    List<_i43.PageRouteInfo>? children,
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

  static const _i43.PageInfo<CreateEESUpoolRouteArgs> page =
      _i43.PageInfo<CreateEESUpoolRouteArgs>(name);
}

class CreateEESUpoolRouteArgs {
  const CreateEESUpoolRouteArgs({
    this.key,
    this.parentId,
    this.level,
    required this.type,
  });

  final _i44.Key? key;

  final int? parentId;

  final _i48.EESUpoolLevel? level;

  final _i49.EESUpoolType type;

  @override
  String toString() {
    return 'CreateEESUpoolRouteArgs{key: $key, parentId: $parentId, level: $level, type: $type}';
  }
}

/// generated route for
/// [_i9.EESUpoolOrderViewScreen]
class EESUpoolOrderViewRoute
    extends _i43.PageRouteInfo<EESUpoolOrderViewRouteArgs> {
  EESUpoolOrderViewRoute({
    _i44.Key? key,
    required _i50.EESUpool pool,
    required _i51.EESUpoolOrder order,
    List<_i43.PageRouteInfo>? children,
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

  static const _i43.PageInfo<EESUpoolOrderViewRouteArgs> page =
      _i43.PageInfo<EESUpoolOrderViewRouteArgs>(name);
}

class EESUpoolOrderViewRouteArgs {
  const EESUpoolOrderViewRouteArgs({
    this.key,
    required this.pool,
    required this.order,
  });

  final _i44.Key? key;

  final _i50.EESUpool pool;

  final _i51.EESUpoolOrder order;

  @override
  String toString() {
    return 'EESUpoolOrderViewRouteArgs{key: $key, pool: $pool, order: $order}';
  }
}

/// generated route for
/// [_i10.EESUpoolSearchScreen]
class EESUpoolSearchRoute extends _i43.PageRouteInfo<EESUpoolSearchRouteArgs> {
  EESUpoolSearchRoute({
    _i44.Key? key,
    required _i49.EESUpoolType type,
    List<_i43.PageRouteInfo>? children,
  }) : super(
          EESUpoolSearchRoute.name,
          args: EESUpoolSearchRouteArgs(
            key: key,
            type: type,
          ),
          initialChildren: children,
        );

  static const String name = 'EESUpoolSearchRoute';

  static const _i43.PageInfo<EESUpoolSearchRouteArgs> page =
      _i43.PageInfo<EESUpoolSearchRouteArgs>(name);
}

class EESUpoolSearchRouteArgs {
  const EESUpoolSearchRouteArgs({
    this.key,
    required this.type,
  });

  final _i44.Key? key;

  final _i49.EESUpoolType type;

  @override
  String toString() {
    return 'EESUpoolSearchRouteArgs{key: $key, type: $type}';
  }
}

/// generated route for
/// [_i11.EESUpoolViewScreen]
class EESUpoolViewRoute extends _i43.PageRouteInfo<EESUpoolViewRouteArgs> {
  EESUpoolViewRoute({
    _i44.Key? key,
    int? poolId,
    _i50.EESUpool? pool,
    List<_i43.PageRouteInfo>? children,
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

  static const _i43.PageInfo<EESUpoolViewRouteArgs> page =
      _i43.PageInfo<EESUpoolViewRouteArgs>(name);
}

class EESUpoolViewRouteArgs {
  const EESUpoolViewRouteArgs({
    this.key,
    this.poolId,
    this.pool,
  });

  final _i44.Key? key;

  final int? poolId;

  final _i50.EESUpool? pool;

  @override
  String toString() {
    return 'EESUpoolViewRouteArgs{key: $key, poolId: $poolId, pool: $pool}';
  }
}

/// generated route for
/// [_i12.EditAddressScreen]
class EditAddressRoute extends _i43.PageRouteInfo<EditAddressRouteArgs> {
  EditAddressRoute({
    _i44.Key? key,
    _i52.Address? address,
    bool isPersonal = true,
    List<_i43.PageRouteInfo>? children,
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

  static const _i43.PageInfo<EditAddressRouteArgs> page =
      _i43.PageInfo<EditAddressRouteArgs>(name);
}

class EditAddressRouteArgs {
  const EditAddressRouteArgs({
    this.key,
    this.address,
    this.isPersonal = true,
  });

  final _i44.Key? key;

  final _i52.Address? address;

  final bool isPersonal;

  @override
  String toString() {
    return 'EditAddressRouteArgs{key: $key, address: $address, isPersonal: $isPersonal}';
  }
}

/// generated route for
/// [_i13.EditApplicationScreen]
class EditApplicationRoute
    extends _i43.PageRouteInfo<EditApplicationRouteArgs> {
  EditApplicationRoute({
    _i44.Key? key,
    required _i53.PartnerApplication app,
    required _i54.Partner partner,
    List<_i43.PageRouteInfo>? children,
  }) : super(
          EditApplicationRoute.name,
          args: EditApplicationRouteArgs(
            key: key,
            app: app,
            partner: partner,
          ),
          initialChildren: children,
        );

  static const String name = 'EditApplicationRoute';

  static const _i43.PageInfo<EditApplicationRouteArgs> page =
      _i43.PageInfo<EditApplicationRouteArgs>(name);
}

class EditApplicationRouteArgs {
  const EditApplicationRouteArgs({
    this.key,
    required this.app,
    required this.partner,
  });

  final _i44.Key? key;

  final _i53.PartnerApplication app;

  final _i54.Partner partner;

  @override
  String toString() {
    return 'EditApplicationRouteArgs{key: $key, app: $app, partner: $partner}';
  }
}

/// generated route for
/// [_i14.EditProfileScreen]
class EditProfileRoute extends _i43.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i44.Key? key,
    required _i55.Profile profile,
    List<_i43.PageRouteInfo>? children,
  }) : super(
          EditProfileRoute.name,
          args: EditProfileRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const _i43.PageInfo<EditProfileRouteArgs> page =
      _i43.PageInfo<EditProfileRouteArgs>(name);
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({
    this.key,
    required this.profile,
  });

  final _i44.Key? key;

  final _i55.Profile profile;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i15.InstapayConfirmDetailsScreen]
class InstapayConfirmDetailsRoute
    extends _i43.PageRouteInfo<InstapayConfirmDetailsRouteArgs> {
  InstapayConfirmDetailsRoute({
    _i44.Key? key,
    required _i56.MerchantTransaction transaction,
    List<_i43.PageRouteInfo>? children,
  }) : super(
          InstapayConfirmDetailsRoute.name,
          args: InstapayConfirmDetailsRouteArgs(
            key: key,
            transaction: transaction,
          ),
          initialChildren: children,
        );

  static const String name = 'InstapayConfirmDetailsRoute';

  static const _i43.PageInfo<InstapayConfirmDetailsRouteArgs> page =
      _i43.PageInfo<InstapayConfirmDetailsRouteArgs>(name);
}

class InstapayConfirmDetailsRouteArgs {
  const InstapayConfirmDetailsRouteArgs({
    this.key,
    required this.transaction,
  });

  final _i44.Key? key;

  final _i56.MerchantTransaction transaction;

  @override
  String toString() {
    return 'InstapayConfirmDetailsRouteArgs{key: $key, transaction: $transaction}';
  }
}

/// generated route for
/// [_i16.InstapayScreen]
class InstapayRoute extends _i43.PageRouteInfo<InstapayRouteArgs> {
  InstapayRoute({
    _i44.Key? key,
    required _i56.MerchantTransaction transaction,
    List<_i43.PageRouteInfo>? children,
  }) : super(
          InstapayRoute.name,
          args: InstapayRouteArgs(
            key: key,
            transaction: transaction,
          ),
          initialChildren: children,
        );

  static const String name = 'InstapayRoute';

  static const _i43.PageInfo<InstapayRouteArgs> page =
      _i43.PageInfo<InstapayRouteArgs>(name);
}

class InstapayRouteArgs {
  const InstapayRouteArgs({
    this.key,
    required this.transaction,
  });

  final _i44.Key? key;

  final _i56.MerchantTransaction transaction;

  @override
  String toString() {
    return 'InstapayRouteArgs{key: $key, transaction: $transaction}';
  }
}

/// generated route for
/// [_i17.IssueViewScreen]
class IssueViewRoute extends _i43.PageRouteInfo<IssueViewRouteArgs> {
  IssueViewRoute({
    _i44.Key? key,
    required _i50.EESUpool pool,
    required _i57.EESUpoolIssue issue,
    List<_i43.PageRouteInfo>? children,
  }) : super(
          IssueViewRoute.name,
          args: IssueViewRouteArgs(
            key: key,
            pool: pool,
            issue: issue,
          ),
          initialChildren: children,
        );

  static const String name = 'IssueViewRoute';

  static const _i43.PageInfo<IssueViewRouteArgs> page =
      _i43.PageInfo<IssueViewRouteArgs>(name);
}

class IssueViewRouteArgs {
  const IssueViewRouteArgs({
    this.key,
    required this.pool,
    required this.issue,
  });

  final _i44.Key? key;

  final _i50.EESUpool pool;

  final _i57.EESUpoolIssue issue;

  @override
  String toString() {
    return 'IssueViewRouteArgs{key: $key, pool: $pool, issue: $issue}';
  }
}

/// generated route for
/// [_i18.KasipreneurScreen]
class KasipreneurRoute extends _i43.PageRouteInfo<KasipreneurRouteArgs> {
  KasipreneurRoute({
    _i44.Key? key,
    required _i58.EESUpreneur eesupreneur,
    List<_i43.PageRouteInfo>? children,
  }) : super(
          KasipreneurRoute.name,
          args: KasipreneurRouteArgs(
            key: key,
            eesupreneur: eesupreneur,
          ),
          initialChildren: children,
        );

  static const String name = 'KasipreneurRoute';

  static const _i43.PageInfo<KasipreneurRouteArgs> page =
      _i43.PageInfo<KasipreneurRouteArgs>(name);
}

class KasipreneurRouteArgs {
  const KasipreneurRouteArgs({
    this.key,
    required this.eesupreneur,
  });

  final _i44.Key? key;

  final _i58.EESUpreneur eesupreneur;

  @override
  String toString() {
    return 'KasipreneurRouteArgs{key: $key, eesupreneur: $eesupreneur}';
  }
}

/// generated route for
/// [_i19.MediaFilePreviewUploaderScreen]
class MediaFilePreviewUploaderRoute extends _i43.PageRouteInfo<void> {
  const MediaFilePreviewUploaderRoute({List<_i43.PageRouteInfo>? children})
      : super(
          MediaFilePreviewUploaderRoute.name,
          initialChildren: children,
        );

  static const String name = 'MediaFilePreviewUploaderRoute';

  static const _i43.PageInfo<void> page = _i43.PageInfo<void>(name);
}

/// generated route for
/// [_i20.OrderReceiverScreen]
class OrderReceiverRoute extends _i43.PageRouteInfo<OrderReceiverRouteArgs> {
  OrderReceiverRoute({
    _i44.Key? key,
    required _i51.EESUpoolOrder order,
    required _i50.EESUpool pool,
    required List<String> ids,
    List<_i43.PageRouteInfo>? children,
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

  static const _i43.PageInfo<OrderReceiverRouteArgs> page =
      _i43.PageInfo<OrderReceiverRouteArgs>(name);
}

class OrderReceiverRouteArgs {
  const OrderReceiverRouteArgs({
    this.key,
    required this.order,
    required this.pool,
    required this.ids,
  });

  final _i44.Key? key;

  final _i51.EESUpoolOrder order;

  final _i50.EESUpool pool;

  final List<String> ids;

  @override
  String toString() {
    return 'OrderReceiverRouteArgs{key: $key, order: $order, pool: $pool, ids: $ids}';
  }
}

/// generated route for
/// [_i21.OrderTrackingScreen]
class OrderTrackingRoute extends _i43.PageRouteInfo<OrderTrackingRouteArgs> {
  OrderTrackingRoute({
    _i44.Key? key,
    required int id,
    required _i59.OrderEditPrivilage privilage,
    List<_i43.PageRouteInfo>? children,
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

  static const _i43.PageInfo<OrderTrackingRouteArgs> page =
      _i43.PageInfo<OrderTrackingRouteArgs>(name);
}

class OrderTrackingRouteArgs {
  const OrderTrackingRouteArgs({
    this.key,
    required this.id,
    required this.privilage,
  });

  final _i44.Key? key;

  final int id;

  final _i59.OrderEditPrivilage privilage;

  @override
  String toString() {
    return 'OrderTrackingRouteArgs{key: $key, id: $id, privilage: $privilage}';
  }
}

/// generated route for
/// [_i22.OverviewScreen]
class OverviewRoute extends _i43.PageRouteInfo<void> {
  const OverviewRoute({List<_i43.PageRouteInfo>? children})
      : super(
          OverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'OverviewRoute';

  static const _i43.PageInfo<void> page = _i43.PageInfo<void>(name);
}

/// generated route for
/// [_i23.OzowScreen]
class OzowRoute extends _i43.PageRouteInfo<OzowRouteArgs> {
  OzowRoute({
    _i44.Key? key,
    required int reference,
    required double amount,
    required String type,
    required String bankRef,
    List<_i43.PageRouteInfo>? children,
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

  static const _i43.PageInfo<OzowRouteArgs> page =
      _i43.PageInfo<OzowRouteArgs>(name);
}

class OzowRouteArgs {
  const OzowRouteArgs({
    this.key,
    required this.reference,
    required this.amount,
    required this.type,
    required this.bankRef,
  });

  final _i44.Key? key;

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
/// [_i24.PartnerAppScreen]
class PartnerAppRoute extends _i43.PageRouteInfo<PartnerAppRouteArgs> {
  PartnerAppRoute({
    _i44.Key? key,
    required _i54.Partner partner,
    List<_i43.PageRouteInfo>? children,
  }) : super(
          PartnerAppRoute.name,
          args: PartnerAppRouteArgs(
            key: key,
            partner: partner,
          ),
          initialChildren: children,
        );

  static const String name = 'PartnerAppRoute';

  static const _i43.PageInfo<PartnerAppRouteArgs> page =
      _i43.PageInfo<PartnerAppRouteArgs>(name);
}

class PartnerAppRouteArgs {
  const PartnerAppRouteArgs({
    this.key,
    required this.partner,
  });

  final _i44.Key? key;

  final _i54.Partner partner;

  @override
  String toString() {
    return 'PartnerAppRouteArgs{key: $key, partner: $partner}';
  }
}

/// generated route for
/// [_i25.PartnerScreen]
class PartnerRoute extends _i43.PageRouteInfo<PartnerRouteArgs> {
  PartnerRoute({
    _i44.Key? key,
    required _i60.UserRole role,
    List<_i43.PageRouteInfo>? children,
  }) : super(
          PartnerRoute.name,
          args: PartnerRouteArgs(
            key: key,
            role: role,
          ),
          initialChildren: children,
        );

  static const String name = 'PartnerRoute';

  static const _i43.PageInfo<PartnerRouteArgs> page =
      _i43.PageInfo<PartnerRouteArgs>(name);
}

class PartnerRouteArgs {
  const PartnerRouteArgs({
    this.key,
    required this.role,
  });

  final _i44.Key? key;

  final _i60.UserRole role;

  @override
  String toString() {
    return 'PartnerRouteArgs{key: $key, role: $role}';
  }
}

/// generated route for
/// [_i26.PayoutScreen]
class PayoutRoute extends _i43.PageRouteInfo<PayoutRouteArgs> {
  PayoutRoute({
    _i44.Key? key,
    required _i61.Wallet wallet,
    List<_i43.PageRouteInfo>? children,
  }) : super(
          PayoutRoute.name,
          args: PayoutRouteArgs(
            key: key,
            wallet: wallet,
          ),
          initialChildren: children,
        );

  static const String name = 'PayoutRoute';

  static const _i43.PageInfo<PayoutRouteArgs> page =
      _i43.PageInfo<PayoutRouteArgs>(name);
}

class PayoutRouteArgs {
  const PayoutRouteArgs({
    this.key,
    required this.wallet,
  });

  final _i44.Key? key;

  final _i61.Wallet wallet;

  @override
  String toString() {
    return 'PayoutRouteArgs{key: $key, wallet: $wallet}';
  }
}

/// generated route for
/// [_i27.ProductRequestScreen]
class ProductRequestRoute extends _i43.PageRouteInfo<void> {
  const ProductRequestRoute({List<_i43.PageRouteInfo>? children})
      : super(
          ProductRequestRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductRequestRoute';

  static const _i43.PageInfo<void> page = _i43.PageInfo<void>(name);
}

/// generated route for
/// [_i28.ProductViewScreen]
class ProductViewRoute extends _i43.PageRouteInfo<ProductViewRouteArgs> {
  ProductViewRoute({
    _i44.Key? key,
    required int id,
    List<_i43.PageRouteInfo>? children,
  }) : super(
          ProductViewRoute.name,
          args: ProductViewRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductViewRoute';

  static const _i43.PageInfo<ProductViewRouteArgs> page =
      _i43.PageInfo<ProductViewRouteArgs>(name);
}

class ProductViewRouteArgs {
  const ProductViewRouteArgs({
    this.key,
    required this.id,
  });

  final _i44.Key? key;

  final int id;

  @override
  String toString() {
    return 'ProductViewRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i29.RegisterScreen]
class RegisterRoute extends _i43.PageRouteInfo<void> {
  const RegisterRoute({List<_i43.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i43.PageInfo<void> page = _i43.PageInfo<void>(name);
}

/// generated route for
/// [_i30.ResetPasswordScreen]
class ResetPasswordRoute extends _i43.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i43.PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i43.PageInfo<void> page = _i43.PageInfo<void>(name);
}

/// generated route for
/// [_i31.ResponseScreen]
class ResponseRoute extends _i43.PageRouteInfo<ResponseRouteArgs> {
  ResponseRoute({
    _i44.Key? key,
    required _i62.Survey survey,
    List<_i43.PageRouteInfo>? children,
  }) : super(
          ResponseRoute.name,
          args: ResponseRouteArgs(
            key: key,
            survey: survey,
          ),
          initialChildren: children,
        );

  static const String name = 'ResponseRoute';

  static const _i43.PageInfo<ResponseRouteArgs> page =
      _i43.PageInfo<ResponseRouteArgs>(name);
}

class ResponseRouteArgs {
  const ResponseRouteArgs({
    this.key,
    required this.survey,
  });

  final _i44.Key? key;

  final _i62.Survey survey;

  @override
  String toString() {
    return 'ResponseRouteArgs{key: $key, survey: $survey}';
  }
}

/// generated route for
/// [_i32.ReviewProductsScreen]
class ReviewProductsRoute extends _i43.PageRouteInfo<ReviewProductsRouteArgs> {
  ReviewProductsRoute({
    _i44.Key? key,
    required _i59.OrderEditPrivilage privilage,
    required _i59.Order order,
    List<_i43.PageRouteInfo>? children,
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

  static const _i43.PageInfo<ReviewProductsRouteArgs> page =
      _i43.PageInfo<ReviewProductsRouteArgs>(name);
}

class ReviewProductsRouteArgs {
  const ReviewProductsRouteArgs({
    this.key,
    required this.privilage,
    required this.order,
  });

  final _i44.Key? key;

  final _i59.OrderEditPrivilage privilage;

  final _i59.Order order;

  @override
  String toString() {
    return 'ReviewProductsRouteArgs{key: $key, privilage: $privilage, order: $order}';
  }
}

/// generated route for
/// [_i33.SettingsScreens]
class SettingsRoutes extends _i43.PageRouteInfo<void> {
  const SettingsRoutes({List<_i43.PageRouteInfo>? children})
      : super(
          SettingsRoutes.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoutes';

  static const _i43.PageInfo<void> page = _i43.PageInfo<void>(name);
}

/// generated route for
/// [_i34.SignInScreen]
class SignInRoute extends _i43.PageRouteInfo<void> {
  const SignInRoute({List<_i43.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const _i43.PageInfo<void> page = _i43.PageInfo<void>(name);
}

/// generated route for
/// [_i35.StartUpScreen]
class StartUpRoute extends _i43.PageRouteInfo<void> {
  const StartUpRoute({List<_i43.PageRouteInfo>? children})
      : super(
          StartUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartUpRoute';

  static const _i43.PageInfo<void> page = _i43.PageInfo<void>(name);
}

/// generated route for
/// [_i36.SupportScreen]
class SupportRoute extends _i43.PageRouteInfo<void> {
  const SupportRoute({List<_i43.PageRouteInfo>? children})
      : super(
          SupportRoute.name,
          initialChildren: children,
        );

  static const String name = 'SupportRoute';

  static const _i43.PageInfo<void> page = _i43.PageInfo<void>(name);
}

/// generated route for
/// [_i37.SurveyScreen]
class SurveyRoute extends _i43.PageRouteInfo<void> {
  const SurveyRoute({List<_i43.PageRouteInfo>? children})
      : super(
          SurveyRoute.name,
          initialChildren: children,
        );

  static const String name = 'SurveyRoute';

  static const _i43.PageInfo<void> page = _i43.PageInfo<void>(name);
}

/// generated route for
/// [_i38.TermsOfServiceScreen]
class TermsOfServiceRoute extends _i43.PageRouteInfo<void> {
  const TermsOfServiceRoute({List<_i43.PageRouteInfo>? children})
      : super(
          TermsOfServiceRoute.name,
          initialChildren: children,
        );

  static const String name = 'TermsOfServiceRoute';

  static const _i43.PageInfo<void> page = _i43.PageInfo<void>(name);
}

/// generated route for
/// [_i39.TransferScreen]
class TransferRoute extends _i43.PageRouteInfo<TransferRouteArgs> {
  TransferRoute({
    _i44.Key? key,
    required _i61.Wallet wallet,
    List<_i43.PageRouteInfo>? children,
  }) : super(
          TransferRoute.name,
          args: TransferRouteArgs(
            key: key,
            wallet: wallet,
          ),
          initialChildren: children,
        );

  static const String name = 'TransferRoute';

  static const _i43.PageInfo<TransferRouteArgs> page =
      _i43.PageInfo<TransferRouteArgs>(name);
}

class TransferRouteArgs {
  const TransferRouteArgs({
    this.key,
    required this.wallet,
  });

  final _i44.Key? key;

  final _i61.Wallet wallet;

  @override
  String toString() {
    return 'TransferRouteArgs{key: $key, wallet: $wallet}';
  }
}

/// generated route for
/// [_i40.VoucherViewScreen]
class VoucherViewRoute extends _i43.PageRouteInfo<VoucherViewRouteArgs> {
  VoucherViewRoute({
    _i44.Key? key,
    required int voucherId,
    List<_i43.PageRouteInfo>? children,
  }) : super(
          VoucherViewRoute.name,
          args: VoucherViewRouteArgs(
            key: key,
            voucherId: voucherId,
          ),
          initialChildren: children,
        );

  static const String name = 'VoucherViewRoute';

  static const _i43.PageInfo<VoucherViewRouteArgs> page =
      _i43.PageInfo<VoucherViewRouteArgs>(name);
}

class VoucherViewRouteArgs {
  const VoucherViewRouteArgs({
    this.key,
    required this.voucherId,
  });

  final _i44.Key? key;

  final int voucherId;

  @override
  String toString() {
    return 'VoucherViewRouteArgs{key: $key, voucherId: $voucherId}';
  }
}

/// generated route for
/// [_i41.WalletViewScreen]
class WalletViewRoute extends _i43.PageRouteInfo<WalletViewRouteArgs> {
  WalletViewRoute({
    _i44.Key? key,
    required int id,
    List<_i43.PageRouteInfo>? children,
  }) : super(
          WalletViewRoute.name,
          args: WalletViewRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'WalletViewRoute';

  static const _i43.PageInfo<WalletViewRouteArgs> page =
      _i43.PageInfo<WalletViewRouteArgs>(name);
}

class WalletViewRouteArgs {
  const WalletViewRouteArgs({
    this.key,
    required this.id,
  });

  final _i44.Key? key;

  final int id;

  @override
  String toString() {
    return 'WalletViewRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i42.YocoPaymentScreen]
class YocoPaymentRoute extends _i43.PageRouteInfo<YocoPaymentRouteArgs> {
  YocoPaymentRoute({
    _i44.Key? key,
    required int reference,
    required double amount,
    List<_i43.PageRouteInfo>? children,
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

  static const _i43.PageInfo<YocoPaymentRouteArgs> page =
      _i43.PageInfo<YocoPaymentRouteArgs>(name);
}

class YocoPaymentRouteArgs {
  const YocoPaymentRouteArgs({
    this.key,
    required this.reference,
    required this.amount,
  });

  final _i44.Key? key;

  final int reference;

  final double amount;

  @override
  String toString() {
    return 'YocoPaymentRouteArgs{key: $key, reference: $reference, amount: $amount}';
  }
}
