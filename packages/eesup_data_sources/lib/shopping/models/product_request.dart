// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_request.freezed.dart';
part 'product_request.g.dart';

@freezed
class ProductRequest with _$ProductRequest {
  const factory ProductRequest({
    @JsonKey(includeToJson: false) required int id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'created_at', includeToJson: false) DateTime? createdAt,
    @JsonKey(name: 'product_id') int? productId,
    @JsonKey(name: 'pack_size') required String packSize,
    required String type,
    required String brand,
    String? variant,
    int? quantity,
  }) = _ProductRequest;

  factory ProductRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductRequestFromJson(json);
}
