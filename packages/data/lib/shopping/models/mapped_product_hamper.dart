import 'package:freezed_annotation/freezed_annotation.dart';

import 'product.dart';

part 'mapped_product_hamper.freezed.dart';
part 'mapped_product_hamper.g.dart';

@freezed
abstract class HamperProductDetail with _$HamperProductDetail {
  factory HamperProductDetail({
    required String hamperId,
    required int productId,
    required int quantity,
    required bool isFree,
    required String name,
    required String brand,
    required String type,
    required String imageUrl,
    required double salePrice,
    required double costPrice,
    required Product product,
  }) = _HamperProductDetail;

  factory HamperProductDetail.fromJson(Map<String, dynamic> json) =>
      _$HamperProductDetailFromJson(json);
}
