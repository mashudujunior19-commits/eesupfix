// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  factory Product({
    required int id,
    @JsonKey(name: 'category_id') int? categoryId,
    required String name,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'image_url') String? imageUrl,
    String? size,
    String? brand,
    String? type,
    String? uom,
    @JsonKey(name: 'unit_pack_size') String? unitPackSize,
    String? flavour,
    @JsonKey(name: 'sale_price') required double salePrice,
    @JsonKey(name: 'cost_price') double? costPrice,
    double? vaa,
    double? vat,
    @JsonKey(name: 'order_max') int? orderMax,
    @JsonKey(name: 'child_id') int? childId,
    @JsonKey(name: 'child_break_qty') int? childBreakQty,
    @JsonKey(name: 'bar_code') String? barCode,
    @JsonKey(name: 'kit_kat_ref') String? kitKatRef,
    @JsonKey(name: 'vat_claimable') bool? vatClaimable,
    @JsonKey(name: 'vat_able') bool? vatAble,
    @ProductClassConverter()
    @JsonKey(name: 'class')
    required ProductClass productClass,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'category_image_url') String? categoryImageUrl,
    @JsonKey(name: 'hamper_id') String? hamperId,
    required bool sellable,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

class ProductClassConverter implements JsonConverter<ProductClass, String> {
  const ProductClassConverter();

  @override
  ProductClass fromJson(String json) {
    return ProductClass.fromString(json);
  }

  @override
  String toJson(ProductClass object) {
    return object.toString();
  }
}

enum ProductClass {
  food,
  crowdfundVoucher,
  airtime,
  mobileData;

  factory ProductClass.fromString(String? str) {
    switch (str) {
      case 'Food':
        return ProductClass.food;
      case 'Crowdfund-voucher':
        return ProductClass.crowdfundVoucher;
      case 'Airtime':
        return ProductClass.airtime;
      case 'Mobile-data':
        return ProductClass.mobileData;
      default:
        return ProductClass.food;
    }
  }

  @override
  String toString() {
    switch (this) {
      case ProductClass.food:
        return 'Food';
      case ProductClass.crowdfundVoucher:
        return 'Crowdfund-voucher';
      case ProductClass.airtime:
        return 'Airtime';
      case ProductClass.mobileData:
        return 'Mobile-data';
      default:
        return 'Food';
    }
  }
}
