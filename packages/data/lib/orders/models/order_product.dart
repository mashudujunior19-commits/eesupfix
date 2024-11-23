// ignore_for_file: invalid_annotation_target

import 'package:data/shopping/models/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_product.freezed.dart';
part 'order_product.g.dart';

@freezed
class OrderProduct with _$OrderProduct {
  factory OrderProduct({
    @JsonKey(name: 'product_id') required int productId,
    @JsonKey(name: 'order_id', includeToJson: false) int? orderId,
    @ProductClassConverter()
    @JsonKey(name: 'class')
    @JsonKey(includeToJson: false)
    @JsonKey(includeToJson: false)
    String? category,
    @JsonKey(includeToJson: false, name: 'image_url') String? imageUrl,
    @JsonKey(includeToJson: false) String? size,
    @ProductClassConverter()
    @JsonKey(includeToJson: false, name: 'class', includeFromJson: true)
    ProductClass? productClass,
    required double price,
    @JsonKey(includeFromJson: false, includeToJson: false) double? costPrice,
    required String name,
    required int quantity,
    @JsonKey(name: 'customer_accepted_qty') @Default(0) int customerAcceptedQty,
    @JsonKey(name: 'eesupreneur_accepted_qty')
    @Default(0)
    int eesupreneurAcceptedQty,
    @JsonKey(name: 'damaged_qty') @Default(0) int damagedQty,
    @JsonKey(name: 'substitute_brand') @Default(false) bool substituteBrand,
    @JsonKey(name: 'substitute_variant') @Default(false) bool substituteVariant,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(false)
    bool isExpanded,
  }) = _OrderProduct;

  factory OrderProduct.empty() => OrderProduct(
        productId: 0,
        name: '',
        price: 0.0,
        quantity: 0,
      );

  factory OrderProduct.fromJson(Map<String, dynamic> json) =>
      _$OrderProductFromJson(json);
}

class OrderProductConverter
    implements JsonConverter<List<OrderProduct>, List<dynamic>> {
  const OrderProductConverter();

  @override
  List<OrderProduct> fromJson(List<dynamic> json) {
    return json.map((e) => OrderProduct.fromJson(e)).toList();
  }

  @override
  List<Map<String, dynamic>> toJson(List<OrderProduct> object) {
    return object.map((e) => e.toJson()).toList();
  }
}
