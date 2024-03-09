// ignore_for_file: invalid_annotation_target

import 'package:eesup_data_source/shopping/models/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'basket_product.freezed.dart';
part 'basket_product.g.dart';

@freezed
class BasketProduct with _$BasketProduct {
  const factory BasketProduct({
    @JsonKey(name: 'basket_id') required String basketId,
    @JsonKey(name: 'product_id') required int productId,
    @JsonKey(name: 'image_url') String? imageUrl,
    required String category,
    required String name,
    required int quantity,
    required double price,
    @JsonKey(name: 'substitute_brand') @Default(false) bool substituteBrand,
    @JsonKey(name: 'substitute_variant') @Default(false) bool substituteVariant,
    String? size,
    @ProductClassConverter()
    @JsonKey(name: 'class')
    required ProductClass productClass,
    required bool sellable,
  }) = _BasketProduct;

  factory BasketProduct.fromJson(Map<String, dynamic> json) =>
      _$BasketProductFromJson(json);
}

class BasketProductConverter
    implements JsonConverter<BasketProduct, Map<String, dynamic>> {
  const BasketProductConverter();

  @override
  BasketProduct fromJson(Map<String, dynamic> json) {
    return BasketProduct.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(BasketProduct object) {
    return object.toJson();
  }
}
