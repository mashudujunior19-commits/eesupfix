// ignore_for_file: invalid_annotation_target


import 'package:freezed_annotation/freezed_annotation.dart';

part 'hamper_product.freezed.dart';
part 'hamper_product.g.dart';

@freezed
abstract class HamperProduct with _$HamperProduct {
  factory HamperProduct({
    @JsonKey(name: 'hamper_id') required String hamperId,
    @JsonKey(name: 'product_id') required int productId,
    required int quantity,
    @JsonKey(name: 'is_free') required bool isFree,
  }) = _HamperProduct;

  factory HamperProduct.fromJson(Map<String, dynamic> json) =>
      _$HamperProductFromJson(json);
}
