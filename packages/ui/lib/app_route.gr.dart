// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i48;
import 'package:data/auth/models/profile.dart' as _i60;
import 'package:data/auth/models/user_role.dart' as _i65;
import 'package:data/eesupools/models/eesupool.dart' as _i55;
import 'package:data/eesupools/models/eesupool_issue.dart' as _i62;
import 'package:data/eesupools/models/eesupool_level.dart' as _i53;
import 'package:data/eesupools/models/eesupool_member.dart' as _i68;
import 'package:data/eesupools/models/eesupool_order.dart' as _i56;
import 'package:data/eesupools/models/eesupool_type.dart' as _i54;
import 'package:data/eesupreneur/models/eesupreneur.dart' as _i63;
import 'package:data/finance/models/wallet.dart' as _i66;
import 'package:data/geolocation/models/address.dart' as _i57;
import 'package:data/orders/models/order.dart' as _i64;
import 'package:data/orders/models/order_product.dart' as _i51;
import 'package:data/partners/models/partner.dart' as _i59;
import 'package:data/partners/models/partner_application.dart' as _i58;
import 'package:data/shopping/models/basket.dart' as _i50;
import 'package:data/shopping/models/category.dart' as _i52;
import 'package:data/surveys/models/survey.dart' as _i67;
import 'package:flutter/material.dart' as _i49;
import 'package:instapay_flutter/data/merchant_transaction.dart' as _i61;
import 'package:ui/src/core/widgets/media_file_uploader.dart' as _i23;
import 'package:ui/src/views/auth/profile/ui/edit_profile_screen.dart' as _i15;
import 'package:ui/src/views/auth/register/ui/register_screen.dart' as _i33;
import 'package:ui/src/views/auth/reset_password/reset_password_screen.dart'
    as _i34;
import 'package:ui/src/views/auth/sign_in/ui/sign_in_screen.dart' as _i38;
import 'package:ui/src/views/auth/sign_in/ui/start_up_screen.dart' as _i39;
import 'package:ui/src/views/eesupools/ui/create_eesupool_screen.dart' as _i9;
import 'package:ui/src/views/eesupools/ui/eesupool_search_screen.dart' as _i11;
import 'package:ui/src/views/eesupools/ui/eesupool_view_screen.dart' as _i12;
import 'package:ui/src/views/eesupools/ui/tabs/issues/ui/issue_view_screen.dart'
    as _i21;
import 'package:ui/src/views/eesupools/ui/tabs/members/ui/transfer_member_screen.dart'
    as _i43;
import 'package:ui/src/views/eesupools/ui/tabs/orders/ui/order_receivers_screen.dart'
    as _i24;
import 'package:ui/src/views/eesupools/ui/tabs/orders/ui/order_view.dart'
    as _i10;
import 'package:ui/src/views/finances/crowdvouchers/ui/voucher_view_screen.dart'
    as _i45;
import 'package:ui/src/views/finances/payments/instapay/instapay_confirm_profile.dart'
    as _i19;
import 'package:ui/src/views/finances/payments/instapay/instapay_screen.dart'
    as _i20;
import 'package:ui/src/views/finances/payments/ozow/ozow_screen.dart' as _i27;
import 'package:ui/src/views/finances/payments/yoco/yoco_payment_screen.dart'
    as _i47;
import 'package:ui/src/views/finances/wallets/ui/screens/payout_screen.dart'
    as _i30;
import 'package:ui/src/views/finances/wallets/ui/screens/transfer_screen.dart'
    as _i44;
import 'package:ui/src/views/finances/wallets/ui/screens/wallet_view_screen.dart'
    as _i46;
import 'package:ui/src/views/geolocation/ui/screens/addrese_book_screen.dart'
    as _i1;
import 'package:ui/src/views/geolocation/ui/screens/edit_address_screen.dart'
    as _i13;
import 'package:ui/src/views/kasipreneur/ui/kasipreneur_screen.dart' as _i22;
import 'package:ui/src/views/menu/terms_of_services_screen.dart' as _i42;
import 'package:ui/src/views/orders/tracking/ui/order_tracking_screen.dart'
    as _i25;
import 'package:ui/src/views/orders/tracking/ui/review_products_screen.dart'
    as _i36;
import 'package:ui/src/views/overview/ui/overview_screen.dart' as _i26;
import 'package:ui/src/views/partners/ui/edit_application.dart' as _i14;
import 'package:ui/src/views/partners/ui/partner_apps_screen.dart' as _i28;
import 'package:ui/src/views/partners/ui/partners_screen.dart' as _i29;
import 'package:ui/src/views/settings/ui/settings_screen.dart' as _i37;
import 'package:ui/src/views/shop/baskets/ui/basket_view.dart' as _i3;
import 'package:ui/src/views/shop/baskets/ui/baskets_list.dart' as _i4;
import 'package:ui/src/views/shop/browsing/ui/browse_shop.dart' as _i5;
import 'package:ui/src/views/shop/browsing/ui/category_screen.dart' as _i7;
import 'package:ui/src/views/shop/browsing/ui/product_view_screen.dart' as _i32;
import 'package:ui/src/views/shop/cart/ui/cart_screen.dart' as _i6;
import 'package:ui/src/views/shop/checkout/ui/checkout_screen.dart' as _i8;
import 'package:ui/src/views/shop/checkout/ui/steps/address_selection_step.dart'
    as _i2;
import 'package:ui/src/views/shop/hampers/ui/hamper_list.dart' as _i18;
import 'package:ui/src/views/shop/hampers/ui/hamper_stack.dart' as _i16;
import 'package:ui/src/views/shop/hampers/ui/hamper_view.dart' as _i17;
import 'package:ui/src/views/shop/product_request/product_request_screen.dart'
    as _i31;
import 'package:ui/src/views/support/ui/support_screen.dart' as _i40;
import 'package:ui/src/views/surveys/ui/response_screen.dart' as _i35;
import 'package:ui/src/views/surveys/ui/survey_screen.dart' as _i41;

/// generated route for
/// [_i1.AddressBookScreen]
class AddressBookRoute extends _i48.PageRouteInfo<void> {
  const AddressBookRoute({List<_i48.PageRouteInfo>? children})
      : super(
          AddressBookRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddressBookRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddressBookScreen();
    },
  );
}

/// generated route for
/// [_i2.AddressSelectionStep]
class AddressSelectionStep
    extends _i48.PageRouteInfo<AddressSelectionStepArgs> {
  AddressSelectionStep({
    _i49.Key? key,
    required _i49.TabController tabController,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          AddressSelectionStep.name,
          args: AddressSelectionStepArgs(
            key: key,
            tabController: tabController,
          ),
          initialChildren: children,
        );

  static const String name = 'AddressSelectionStep';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddressSelectionStepArgs>();
      return _i2.AddressSelectionStep(
        key: args.key,
        tabController: args.tabController,
      );
    },
  );
}

class AddressSelectionStepArgs {
  const AddressSelectionStepArgs({
    this.key,
    required this.tabController,
  });

  final _i49.Key? key;

  final _i49.TabController tabController;

  @override
  String toString() {
    return 'AddressSelectionStepArgs{key: $key, tabController: $tabController}';
  }
}

/// generated route for
/// [_i3.BasketViewScreen]
class BasketViewRoute extends _i48.PageRouteInfo<BasketViewRouteArgs> {
  BasketViewRoute({
    _i49.Key? key,
    required _i50.Basket basket,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          BasketViewRoute.name,
          args: BasketViewRouteArgs(
            key: key,
            basket: basket,
          ),
          initialChildren: children,
        );

  static const String name = 'BasketViewRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BasketViewRouteArgs>();
      return _i3.BasketViewScreen(
        key: args.key,
        basket: args.basket,
      );
    },
  );
}

class BasketViewRouteArgs {
  const BasketViewRouteArgs({
    this.key,
    required this.basket,
  });

  final _i49.Key? key;

  final _i50.Basket basket;

  @override
  String toString() {
    return 'BasketViewRouteArgs{key: $key, basket: $basket}';
  }
}

/// generated route for
/// [_i4.BasketsListScreen]
class BasketsListRoute extends _i48.PageRouteInfo<void> {
  const BasketsListRoute({List<_i48.PageRouteInfo>? children})
      : super(
          BasketsListRoute.name,
          initialChildren: children,
        );

  static const String name = 'BasketsListRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i4.BasketsListScreen();
    },
  );
}

/// generated route for
/// [_i5.BrowseShopScreen]
class BrowseShopRoute extends _i48.PageRouteInfo<void> {
  const BrowseShopRoute({List<_i48.PageRouteInfo>? children})
      : super(
          BrowseShopRoute.name,
          initialChildren: children,
        );

  static const String name = 'BrowseShopRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i5.BrowseShopScreen();
    },
  );
}

/// generated route for
/// [_i6.CartScreen]
class CartRoute extends _i48.PageRouteInfo<CartRouteArgs> {
  CartRoute({
    _i49.Key? key,
    List<_i51.OrderProduct>? orderProducts,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          CartRoute.name,
          args: CartRouteArgs(
            key: key,
            orderProducts: orderProducts,
          ),
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<CartRouteArgs>(orElse: () => const CartRouteArgs());
      return _i6.CartScreen(
        key: args.key,
        orderProducts: args.orderProducts,
      );
    },
  );
}

class CartRouteArgs {
  const CartRouteArgs({
    this.key,
    this.orderProducts,
  });

  final _i49.Key? key;

  final List<_i51.OrderProduct>? orderProducts;

  @override
  String toString() {
    return 'CartRouteArgs{key: $key, orderProducts: $orderProducts}';
  }
}

/// generated route for
/// [_i7.CategoryScreen]
class CategoryRoute extends _i48.PageRouteInfo<CategoryRouteArgs> {
  CategoryRoute({
    _i49.Key? key,
    required _i52.Category category,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          CategoryRoute.name,
          args: CategoryRouteArgs(
            key: key,
            category: category,
          ),
          initialChildren: children,
        );

  static const String name = 'CategoryRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CategoryRouteArgs>();
      return _i7.CategoryScreen(
        key: args.key,
        category: args.category,
      );
    },
  );
}

class CategoryRouteArgs {
  const CategoryRouteArgs({
    this.key,
    required this.category,
  });

  final _i49.Key? key;

  final _i52.Category category;

  @override
  String toString() {
    return 'CategoryRouteArgs{key: $key, category: $category}';
  }
}

/// generated route for
/// [_i8.CheckoutScreen]
class CheckoutRoute extends _i48.PageRouteInfo<CheckoutRouteArgs> {
  CheckoutRoute({
    _i49.Key? key,
    required List<_i51.OrderProduct> products,
    required double total,
    List<_i48.PageRouteInfo>? children,
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

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CheckoutRouteArgs>();
      return _i8.CheckoutScreen(
        key: args.key,
        products: args.products,
        total: args.total,
      );
    },
  );
}

class CheckoutRouteArgs {
  const CheckoutRouteArgs({
    this.key,
    required this.products,
    required this.total,
  });

  final _i49.Key? key;

  final List<_i51.OrderProduct> products;

  final double total;

  @override
  String toString() {
    return 'CheckoutRouteArgs{key: $key, products: $products, total: $total}';
  }
}

/// generated route for
/// [_i9.CreateEESUpoolScreen]
class CreateEESUpoolRoute extends _i48.PageRouteInfo<CreateEESUpoolRouteArgs> {
  CreateEESUpoolRoute({
    _i49.Key? key,
    int? parentId,
    _i53.EESUpoolLevel? level,
    required _i54.EESUpoolType type,
    List<_i48.PageRouteInfo>? children,
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

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateEESUpoolRouteArgs>();
      return _i9.CreateEESUpoolScreen(
        key: args.key,
        parentId: args.parentId,
        level: args.level,
        type: args.type,
      );
    },
  );
}

class CreateEESUpoolRouteArgs {
  const CreateEESUpoolRouteArgs({
    this.key,
    this.parentId,
    this.level,
    required this.type,
  });

  final _i49.Key? key;

  final int? parentId;

  final _i53.EESUpoolLevel? level;

  final _i54.EESUpoolType type;

  @override
  String toString() {
    return 'CreateEESUpoolRouteArgs{key: $key, parentId: $parentId, level: $level, type: $type}';
  }
}

/// generated route for
/// [_i10.EESUpoolOrderViewScreen]
class EESUpoolOrderViewRoute
    extends _i48.PageRouteInfo<EESUpoolOrderViewRouteArgs> {
  EESUpoolOrderViewRoute({
    _i49.Key? key,
    required _i55.EESUpool pool,
    required _i56.EESUpoolOrder order,
    List<_i48.PageRouteInfo>? children,
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

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EESUpoolOrderViewRouteArgs>();
      return _i10.EESUpoolOrderViewScreen(
        key: args.key,
        pool: args.pool,
        order: args.order,
      );
    },
  );
}

class EESUpoolOrderViewRouteArgs {
  const EESUpoolOrderViewRouteArgs({
    this.key,
    required this.pool,
    required this.order,
  });

  final _i49.Key? key;

  final _i55.EESUpool pool;

  final _i56.EESUpoolOrder order;

  @override
  String toString() {
    return 'EESUpoolOrderViewRouteArgs{key: $key, pool: $pool, order: $order}';
  }
}

/// generated route for
/// [_i11.EESUpoolSearchScreen]
class EESUpoolSearchRoute extends _i48.PageRouteInfo<EESUpoolSearchRouteArgs> {
  EESUpoolSearchRoute({
    _i49.Key? key,
    required _i54.EESUpoolType type,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          EESUpoolSearchRoute.name,
          args: EESUpoolSearchRouteArgs(
            key: key,
            type: type,
          ),
          initialChildren: children,
        );

  static const String name = 'EESUpoolSearchRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EESUpoolSearchRouteArgs>();
      return _i11.EESUpoolSearchScreen(
        key: args.key,
        type: args.type,
      );
    },
  );
}

class EESUpoolSearchRouteArgs {
  const EESUpoolSearchRouteArgs({
    this.key,
    required this.type,
  });

  final _i49.Key? key;

  final _i54.EESUpoolType type;

  @override
  String toString() {
    return 'EESUpoolSearchRouteArgs{key: $key, type: $type}';
  }
}

/// generated route for
/// [_i12.EESUpoolViewScreen]
class EESUpoolViewRoute extends _i48.PageRouteInfo<EESUpoolViewRouteArgs> {
  EESUpoolViewRoute({
    _i49.Key? key,
    int? poolId,
    _i55.EESUpool? pool,
    List<_i48.PageRouteInfo>? children,
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

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EESUpoolViewRouteArgs>(
          orElse: () => const EESUpoolViewRouteArgs());
      return _i12.EESUpoolViewScreen(
        key: args.key,
        poolId: args.poolId,
        pool: args.pool,
      );
    },
  );
}

class EESUpoolViewRouteArgs {
  const EESUpoolViewRouteArgs({
    this.key,
    this.poolId,
    this.pool,
  });

  final _i49.Key? key;

  final int? poolId;

  final _i55.EESUpool? pool;

  @override
  String toString() {
    return 'EESUpoolViewRouteArgs{key: $key, poolId: $poolId, pool: $pool}';
  }
}

/// generated route for
/// [_i13.EditAddressScreen]
class EditAddressRoute extends _i48.PageRouteInfo<EditAddressRouteArgs> {
  EditAddressRoute({
    _i49.Key? key,
    _i57.Address? address,
    bool isPersonal = true,
    List<_i48.PageRouteInfo>? children,
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

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditAddressRouteArgs>(
          orElse: () => const EditAddressRouteArgs());
      return _i13.EditAddressScreen(
        key: args.key,
        address: args.address,
        isPersonal: args.isPersonal,
      );
    },
  );
}

class EditAddressRouteArgs {
  const EditAddressRouteArgs({
    this.key,
    this.address,
    this.isPersonal = true,
  });

  final _i49.Key? key;

  final _i57.Address? address;

  final bool isPersonal;

  @override
  String toString() {
    return 'EditAddressRouteArgs{key: $key, address: $address, isPersonal: $isPersonal}';
  }
}

/// generated route for
/// [_i14.EditApplicationScreen]
class EditApplicationRoute
    extends _i48.PageRouteInfo<EditApplicationRouteArgs> {
  EditApplicationRoute({
    _i49.Key? key,
    required _i58.PartnerApplication app,
    required _i59.Partner partner,
    List<_i48.PageRouteInfo>? children,
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

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditApplicationRouteArgs>();
      return _i14.EditApplicationScreen(
        key: args.key,
        app: args.app,
        partner: args.partner,
      );
    },
  );
}

class EditApplicationRouteArgs {
  const EditApplicationRouteArgs({
    this.key,
    required this.app,
    required this.partner,
  });

  final _i49.Key? key;

  final _i58.PartnerApplication app;

  final _i59.Partner partner;

  @override
  String toString() {
    return 'EditApplicationRouteArgs{key: $key, app: $app, partner: $partner}';
  }
}

/// generated route for
/// [_i15.EditProfileScreen]
class EditProfileRoute extends _i48.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i49.Key? key,
    required _i60.Profile profile,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          EditProfileRoute.name,
          args: EditProfileRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditProfileRouteArgs>();
      return _i15.EditProfileScreen(
        key: args.key,
        profile: args.profile,
      );
    },
  );
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({
    this.key,
    required this.profile,
  });

  final _i49.Key? key;

  final _i60.Profile profile;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i16.HamperImageStack]
class HamperImageStack extends _i48.PageRouteInfo<HamperImageStackArgs> {
  HamperImageStack({
    _i49.Key? key,
    required String? imgUrl,
    String? hamperCode,
    double? hamperPrice,
    double? profitpercentage,
    String? hamperGifUrl1,
    String? hamperGifUrl2,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          HamperImageStack.name,
          args: HamperImageStackArgs(
            key: key,
            imgUrl: imgUrl,
            hamperCode: hamperCode,
            hamperPrice: hamperPrice,
            profitpercentage: profitpercentage,
            hamperGifUrl1: hamperGifUrl1,
            hamperGifUrl2: hamperGifUrl2,
          ),
          initialChildren: children,
        );

  static const String name = 'HamperImageStack';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HamperImageStackArgs>();
      return _i16.HamperImageStack(
        key: args.key,
        imgUrl: args.imgUrl,
        hamperCode: args.hamperCode,
        hamperPrice: args.hamperPrice,
        profitpercentage: args.profitpercentage,
        hamperGifUrl1: args.hamperGifUrl1,
        hamperGifUrl2: args.hamperGifUrl2,
      );
    },
  );
}

class HamperImageStackArgs {
  const HamperImageStackArgs({
    this.key,
    required this.imgUrl,
    this.hamperCode,
    this.hamperPrice,
    this.profitpercentage,
    this.hamperGifUrl1,
    this.hamperGifUrl2,
  });

  final _i49.Key? key;

  final String? imgUrl;

  final String? hamperCode;

  final double? hamperPrice;

  final double? profitpercentage;

  final String? hamperGifUrl1;

  final String? hamperGifUrl2;

  @override
  String toString() {
    return 'HamperImageStackArgs{key: $key, imgUrl: $imgUrl, hamperCode: $hamperCode, hamperPrice: $hamperPrice, profitpercentage: $profitpercentage, hamperGifUrl1: $hamperGifUrl1, hamperGifUrl2: $hamperGifUrl2}';
  }
}

/// generated route for
/// [_i17.HamperViewPage]
class HamperViewRoute extends _i48.PageRouteInfo<HamperViewRouteArgs> {
  HamperViewRoute({
    _i49.Key? key,
    String? hamperId,
    String? imageUrl,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          HamperViewRoute.name,
          args: HamperViewRouteArgs(
            key: key,
            hamperId: hamperId,
            imageUrl: imageUrl,
          ),
          initialChildren: children,
        );

  static const String name = 'HamperViewRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HamperViewRouteArgs>(
          orElse: () => const HamperViewRouteArgs());
      return _i17.HamperViewPage(
        key: args.key,
        hamperId: args.hamperId,
        imageUrl: args.imageUrl,
      );
    },
  );
}

class HamperViewRouteArgs {
  const HamperViewRouteArgs({
    this.key,
    this.hamperId,
    this.imageUrl,
  });

  final _i49.Key? key;

  final String? hamperId;

  final String? imageUrl;

  @override
  String toString() {
    return 'HamperViewRouteArgs{key: $key, hamperId: $hamperId, imageUrl: $imageUrl}';
  }
}

/// generated route for
/// [_i18.HampersList]
class HampersList extends _i48.PageRouteInfo<void> {
  const HampersList({List<_i48.PageRouteInfo>? children})
      : super(
          HampersList.name,
          initialChildren: children,
        );

  static const String name = 'HampersList';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i18.HampersList();
    },
  );
}

/// generated route for
/// [_i19.InstapayConfirmDetailsScreen]
class InstapayConfirmDetailsRoute
    extends _i48.PageRouteInfo<InstapayConfirmDetailsRouteArgs> {
  InstapayConfirmDetailsRoute({
    _i49.Key? key,
    required _i61.MerchantTransaction transaction,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          InstapayConfirmDetailsRoute.name,
          args: InstapayConfirmDetailsRouteArgs(
            key: key,
            transaction: transaction,
          ),
          initialChildren: children,
        );

  static const String name = 'InstapayConfirmDetailsRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<InstapayConfirmDetailsRouteArgs>();
      return _i19.InstapayConfirmDetailsScreen(
        key: args.key,
        transaction: args.transaction,
      );
    },
  );
}

class InstapayConfirmDetailsRouteArgs {
  const InstapayConfirmDetailsRouteArgs({
    this.key,
    required this.transaction,
  });

  final _i49.Key? key;

  final _i61.MerchantTransaction transaction;

  @override
  String toString() {
    return 'InstapayConfirmDetailsRouteArgs{key: $key, transaction: $transaction}';
  }
}

/// generated route for
/// [_i20.InstapayScreen]
class InstapayRoute extends _i48.PageRouteInfo<InstapayRouteArgs> {
  InstapayRoute({
    _i49.Key? key,
    required _i61.MerchantTransaction transaction,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          InstapayRoute.name,
          args: InstapayRouteArgs(
            key: key,
            transaction: transaction,
          ),
          initialChildren: children,
        );

  static const String name = 'InstapayRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<InstapayRouteArgs>();
      return _i20.InstapayScreen(
        key: args.key,
        transaction: args.transaction,
      );
    },
  );
}

class InstapayRouteArgs {
  const InstapayRouteArgs({
    this.key,
    required this.transaction,
  });

  final _i49.Key? key;

  final _i61.MerchantTransaction transaction;

  @override
  String toString() {
    return 'InstapayRouteArgs{key: $key, transaction: $transaction}';
  }
}

/// generated route for
/// [_i21.IssueViewScreen]
class IssueViewRoute extends _i48.PageRouteInfo<IssueViewRouteArgs> {
  IssueViewRoute({
    _i49.Key? key,
    required _i55.EESUpool pool,
    required _i62.EESUpoolIssue issue,
    List<_i48.PageRouteInfo>? children,
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

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<IssueViewRouteArgs>();
      return _i21.IssueViewScreen(
        key: args.key,
        pool: args.pool,
        issue: args.issue,
      );
    },
  );
}

class IssueViewRouteArgs {
  const IssueViewRouteArgs({
    this.key,
    required this.pool,
    required this.issue,
  });

  final _i49.Key? key;

  final _i55.EESUpool pool;

  final _i62.EESUpoolIssue issue;

  @override
  String toString() {
    return 'IssueViewRouteArgs{key: $key, pool: $pool, issue: $issue}';
  }
}

/// generated route for
/// [_i22.KasipreneurScreen]
class KasipreneurRoute extends _i48.PageRouteInfo<KasipreneurRouteArgs> {
  KasipreneurRoute({
    _i49.Key? key,
    required _i63.EESUpreneur eesupreneur,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          KasipreneurRoute.name,
          args: KasipreneurRouteArgs(
            key: key,
            eesupreneur: eesupreneur,
          ),
          initialChildren: children,
        );

  static const String name = 'KasipreneurRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<KasipreneurRouteArgs>();
      return _i22.KasipreneurScreen(
        key: args.key,
        eesupreneur: args.eesupreneur,
      );
    },
  );
}

class KasipreneurRouteArgs {
  const KasipreneurRouteArgs({
    this.key,
    required this.eesupreneur,
  });

  final _i49.Key? key;

  final _i63.EESUpreneur eesupreneur;

  @override
  String toString() {
    return 'KasipreneurRouteArgs{key: $key, eesupreneur: $eesupreneur}';
  }
}

/// generated route for
/// [_i23.MediaFilePreviewUploaderScreen]
class MediaFilePreviewUploaderRoute extends _i48.PageRouteInfo<void> {
  const MediaFilePreviewUploaderRoute({List<_i48.PageRouteInfo>? children})
      : super(
          MediaFilePreviewUploaderRoute.name,
          initialChildren: children,
        );

  static const String name = 'MediaFilePreviewUploaderRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i23.MediaFilePreviewUploaderScreen();
    },
  );
}

/// generated route for
/// [_i24.OrderReceiverScreen]
class OrderReceiverRoute extends _i48.PageRouteInfo<OrderReceiverRouteArgs> {
  OrderReceiverRoute({
    _i49.Key? key,
    required _i56.EESUpoolOrder order,
    required _i55.EESUpool pool,
    required List<String> ids,
    List<_i48.PageRouteInfo>? children,
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

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderReceiverRouteArgs>();
      return _i24.OrderReceiverScreen(
        key: args.key,
        order: args.order,
        pool: args.pool,
        ids: args.ids,
      );
    },
  );
}

class OrderReceiverRouteArgs {
  const OrderReceiverRouteArgs({
    this.key,
    required this.order,
    required this.pool,
    required this.ids,
  });

  final _i49.Key? key;

  final _i56.EESUpoolOrder order;

  final _i55.EESUpool pool;

  final List<String> ids;

  @override
  String toString() {
    return 'OrderReceiverRouteArgs{key: $key, order: $order, pool: $pool, ids: $ids}';
  }
}

/// generated route for
/// [_i25.OrderTrackingScreen]
class OrderTrackingRoute extends _i48.PageRouteInfo<OrderTrackingRouteArgs> {
  OrderTrackingRoute({
    _i49.Key? key,
    required int id,
    required _i64.OrderEditPrivilage privilage,
    List<_i48.PageRouteInfo>? children,
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

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderTrackingRouteArgs>();
      return _i25.OrderTrackingScreen(
        key: args.key,
        id: args.id,
        privilage: args.privilage,
      );
    },
  );
}

class OrderTrackingRouteArgs {
  const OrderTrackingRouteArgs({
    this.key,
    required this.id,
    required this.privilage,
  });

  final _i49.Key? key;

  final int id;

  final _i64.OrderEditPrivilage privilage;

  @override
  String toString() {
    return 'OrderTrackingRouteArgs{key: $key, id: $id, privilage: $privilage}';
  }
}

/// generated route for
/// [_i26.OverviewScreen]
class OverviewRoute extends _i48.PageRouteInfo<void> {
  const OverviewRoute({List<_i48.PageRouteInfo>? children})
      : super(
          OverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'OverviewRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i26.OverviewScreen();
    },
  );
}

/// generated route for
/// [_i27.OzowScreen]
class OzowRoute extends _i48.PageRouteInfo<OzowRouteArgs> {
  OzowRoute({
    _i49.Key? key,
    required int reference,
    required double amount,
    required String type,
    required String bankRef,
    List<_i48.PageRouteInfo>? children,
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

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OzowRouteArgs>();
      return _i27.OzowScreen(
        key: args.key,
        reference: args.reference,
        amount: args.amount,
        type: args.type,
        bankRef: args.bankRef,
      );
    },
  );
}

class OzowRouteArgs {
  const OzowRouteArgs({
    this.key,
    required this.reference,
    required this.amount,
    required this.type,
    required this.bankRef,
  });

  final _i49.Key? key;

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
/// [_i28.PartnerAppScreen]
class PartnerAppRoute extends _i48.PageRouteInfo<PartnerAppRouteArgs> {
  PartnerAppRoute({
    _i49.Key? key,
    required _i59.Partner partner,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          PartnerAppRoute.name,
          args: PartnerAppRouteArgs(
            key: key,
            partner: partner,
          ),
          initialChildren: children,
        );

  static const String name = 'PartnerAppRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PartnerAppRouteArgs>();
      return _i28.PartnerAppScreen(
        key: args.key,
        partner: args.partner,
      );
    },
  );
}

class PartnerAppRouteArgs {
  const PartnerAppRouteArgs({
    this.key,
    required this.partner,
  });

  final _i49.Key? key;

  final _i59.Partner partner;

  @override
  String toString() {
    return 'PartnerAppRouteArgs{key: $key, partner: $partner}';
  }
}

/// generated route for
/// [_i29.PartnerScreen]
class PartnerRoute extends _i48.PageRouteInfo<PartnerRouteArgs> {
  PartnerRoute({
    _i49.Key? key,
    required _i65.UserRole role,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          PartnerRoute.name,
          args: PartnerRouteArgs(
            key: key,
            role: role,
          ),
          initialChildren: children,
        );

  static const String name = 'PartnerRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PartnerRouteArgs>();
      return _i29.PartnerScreen(
        key: args.key,
        role: args.role,
      );
    },
  );
}

class PartnerRouteArgs {
  const PartnerRouteArgs({
    this.key,
    required this.role,
  });

  final _i49.Key? key;

  final _i65.UserRole role;

  @override
  String toString() {
    return 'PartnerRouteArgs{key: $key, role: $role}';
  }
}

/// generated route for
/// [_i30.PayoutScreen]
class PayoutRoute extends _i48.PageRouteInfo<PayoutRouteArgs> {
  PayoutRoute({
    _i49.Key? key,
    required _i66.Wallet wallet,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          PayoutRoute.name,
          args: PayoutRouteArgs(
            key: key,
            wallet: wallet,
          ),
          initialChildren: children,
        );

  static const String name = 'PayoutRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PayoutRouteArgs>();
      return _i30.PayoutScreen(
        key: args.key,
        wallet: args.wallet,
      );
    },
  );
}

class PayoutRouteArgs {
  const PayoutRouteArgs({
    this.key,
    required this.wallet,
  });

  final _i49.Key? key;

  final _i66.Wallet wallet;

  @override
  String toString() {
    return 'PayoutRouteArgs{key: $key, wallet: $wallet}';
  }
}

/// generated route for
/// [_i31.ProductRequestScreen]
class ProductRequestRoute extends _i48.PageRouteInfo<void> {
  const ProductRequestRoute({List<_i48.PageRouteInfo>? children})
      : super(
          ProductRequestRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductRequestRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i31.ProductRequestScreen();
    },
  );
}

/// generated route for
/// [_i32.ProductViewScreen]
class ProductViewRoute extends _i48.PageRouteInfo<ProductViewRouteArgs> {
  ProductViewRoute({
    _i49.Key? key,
    required int id,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          ProductViewRoute.name,
          args: ProductViewRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductViewRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductViewRouteArgs>();
      return _i32.ProductViewScreen(
        key: args.key,
        id: args.id,
      );
    },
  );
}

class ProductViewRouteArgs {
  const ProductViewRouteArgs({
    this.key,
    required this.id,
  });

  final _i49.Key? key;

  final int id;

  @override
  String toString() {
    return 'ProductViewRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i33.RegisterScreen]
class RegisterRoute extends _i48.PageRouteInfo<void> {
  const RegisterRoute({List<_i48.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i33.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i34.ResetPasswordScreen]
class ResetPasswordRoute extends _i48.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i48.PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i34.ResetPasswordScreen();
    },
  );
}

/// generated route for
/// [_i35.ResponseScreen]
class ResponseRoute extends _i48.PageRouteInfo<ResponseRouteArgs> {
  ResponseRoute({
    _i49.Key? key,
    required _i67.Survey survey,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          ResponseRoute.name,
          args: ResponseRouteArgs(
            key: key,
            survey: survey,
          ),
          initialChildren: children,
        );

  static const String name = 'ResponseRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResponseRouteArgs>();
      return _i35.ResponseScreen(
        key: args.key,
        survey: args.survey,
      );
    },
  );
}

class ResponseRouteArgs {
  const ResponseRouteArgs({
    this.key,
    required this.survey,
  });

  final _i49.Key? key;

  final _i67.Survey survey;

  @override
  String toString() {
    return 'ResponseRouteArgs{key: $key, survey: $survey}';
  }
}

/// generated route for
/// [_i36.ReviewProductsScreen]
class ReviewProductsRoute extends _i48.PageRouteInfo<ReviewProductsRouteArgs> {
  ReviewProductsRoute({
    _i49.Key? key,
    required _i64.OrderEditPrivilage privilage,
    required _i64.Order order,
    List<_i48.PageRouteInfo>? children,
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

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReviewProductsRouteArgs>();
      return _i36.ReviewProductsScreen(
        key: args.key,
        privilage: args.privilage,
        order: args.order,
      );
    },
  );
}

class ReviewProductsRouteArgs {
  const ReviewProductsRouteArgs({
    this.key,
    required this.privilage,
    required this.order,
  });

  final _i49.Key? key;

  final _i64.OrderEditPrivilage privilage;

  final _i64.Order order;

  @override
  String toString() {
    return 'ReviewProductsRouteArgs{key: $key, privilage: $privilage, order: $order}';
  }
}

/// generated route for
/// [_i37.SettingsScreens]
class SettingsRoutes extends _i48.PageRouteInfo<void> {
  const SettingsRoutes({List<_i48.PageRouteInfo>? children})
      : super(
          SettingsRoutes.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoutes';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i37.SettingsScreens();
    },
  );
}

/// generated route for
/// [_i38.SignInScreen]
class SignInRoute extends _i48.PageRouteInfo<void> {
  const SignInRoute({List<_i48.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i38.SignInScreen();
    },
  );
}

/// generated route for
/// [_i39.StartUpScreen]
class StartUpRoute extends _i48.PageRouteInfo<void> {
  const StartUpRoute({List<_i48.PageRouteInfo>? children})
      : super(
          StartUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartUpRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i39.StartUpScreen();
    },
  );
}

/// generated route for
/// [_i40.SupportScreen]
class SupportRoute extends _i48.PageRouteInfo<void> {
  const SupportRoute({List<_i48.PageRouteInfo>? children})
      : super(
          SupportRoute.name,
          initialChildren: children,
        );

  static const String name = 'SupportRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i40.SupportScreen();
    },
  );
}

/// generated route for
/// [_i41.SurveyScreen]
class SurveyRoute extends _i48.PageRouteInfo<void> {
  const SurveyRoute({List<_i48.PageRouteInfo>? children})
      : super(
          SurveyRoute.name,
          initialChildren: children,
        );

  static const String name = 'SurveyRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i41.SurveyScreen();
    },
  );
}

/// generated route for
/// [_i42.TermsOfServiceScreen]
class TermsOfServiceRoute extends _i48.PageRouteInfo<void> {
  const TermsOfServiceRoute({List<_i48.PageRouteInfo>? children})
      : super(
          TermsOfServiceRoute.name,
          initialChildren: children,
        );

  static const String name = 'TermsOfServiceRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i42.TermsOfServiceScreen();
    },
  );
}

/// generated route for
/// [_i43.TransferMemberScreen]
class TransferMemberRoute extends _i48.PageRouteInfo<TransferMemberRouteArgs> {
  TransferMemberRoute({
    _i49.Key? key,
    required _i68.EESUpoolMember member,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          TransferMemberRoute.name,
          args: TransferMemberRouteArgs(
            key: key,
            member: member,
          ),
          initialChildren: children,
        );

  static const String name = 'TransferMemberRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TransferMemberRouteArgs>();
      return _i43.TransferMemberScreen(
        key: args.key,
        member: args.member,
      );
    },
  );
}

class TransferMemberRouteArgs {
  const TransferMemberRouteArgs({
    this.key,
    required this.member,
  });

  final _i49.Key? key;

  final _i68.EESUpoolMember member;

  @override
  String toString() {
    return 'TransferMemberRouteArgs{key: $key, member: $member}';
  }
}

/// generated route for
/// [_i44.TransferScreen]
class TransferRoute extends _i48.PageRouteInfo<TransferRouteArgs> {
  TransferRoute({
    _i49.Key? key,
    required _i66.Wallet wallet,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          TransferRoute.name,
          args: TransferRouteArgs(
            key: key,
            wallet: wallet,
          ),
          initialChildren: children,
        );

  static const String name = 'TransferRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TransferRouteArgs>();
      return _i44.TransferScreen(
        key: args.key,
        wallet: args.wallet,
      );
    },
  );
}

class TransferRouteArgs {
  const TransferRouteArgs({
    this.key,
    required this.wallet,
  });

  final _i49.Key? key;

  final _i66.Wallet wallet;

  @override
  String toString() {
    return 'TransferRouteArgs{key: $key, wallet: $wallet}';
  }
}

/// generated route for
/// [_i45.VoucherViewScreen]
class VoucherViewRoute extends _i48.PageRouteInfo<VoucherViewRouteArgs> {
  VoucherViewRoute({
    _i49.Key? key,
    required int voucherId,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          VoucherViewRoute.name,
          args: VoucherViewRouteArgs(
            key: key,
            voucherId: voucherId,
          ),
          initialChildren: children,
        );

  static const String name = 'VoucherViewRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VoucherViewRouteArgs>();
      return _i45.VoucherViewScreen(
        key: args.key,
        voucherId: args.voucherId,
      );
    },
  );
}

class VoucherViewRouteArgs {
  const VoucherViewRouteArgs({
    this.key,
    required this.voucherId,
  });

  final _i49.Key? key;

  final int voucherId;

  @override
  String toString() {
    return 'VoucherViewRouteArgs{key: $key, voucherId: $voucherId}';
  }
}

/// generated route for
/// [_i46.WalletViewScreen]
class WalletViewRoute extends _i48.PageRouteInfo<WalletViewRouteArgs> {
  WalletViewRoute({
    _i49.Key? key,
    required int id,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          WalletViewRoute.name,
          args: WalletViewRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'WalletViewRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WalletViewRouteArgs>();
      return _i46.WalletViewScreen(
        key: args.key,
        id: args.id,
      );
    },
  );
}

class WalletViewRouteArgs {
  const WalletViewRouteArgs({
    this.key,
    required this.id,
  });

  final _i49.Key? key;

  final int id;

  @override
  String toString() {
    return 'WalletViewRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i47.YocoPaymentScreen]
class YocoPaymentRoute extends _i48.PageRouteInfo<YocoPaymentRouteArgs> {
  YocoPaymentRoute({
    _i49.Key? key,
    required int reference,
    required double amount,
    List<_i48.PageRouteInfo>? children,
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

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<YocoPaymentRouteArgs>();
      return _i47.YocoPaymentScreen(
        key: args.key,
        reference: args.reference,
        amount: args.amount,
      );
    },
  );
}

class YocoPaymentRouteArgs {
  const YocoPaymentRouteArgs({
    this.key,
    required this.reference,
    required this.amount,
  });

  final _i49.Key? key;

  final int reference;

  final double amount;

  @override
  String toString() {
    return 'YocoPaymentRouteArgs{key: $key, reference: $reference, amount: $amount}';
  }
}
