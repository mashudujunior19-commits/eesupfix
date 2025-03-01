// ignore_for_file: invalid_annotation_target, constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'basket.freezed.dart';
part 'basket.g.dart';

@freezed
abstract class Basket with _$Basket {
  const factory Basket({
    @JsonKey(includeToJson: false) required String id,
    required String name,
    @BasketTypeConverter() BasketType? type,
  }) = _Basket;

  factory Basket.fromJson(Map<String, dynamic> json) => _$BasketFromJson(json);
}

class BasketTypeConverter implements JsonConverter<BasketType, String> {
  const BasketTypeConverter();

  @override
  BasketType fromJson(String type) {
    return BasketType.fromJson(type);
  }

  @override
  String toJson(BasketType type) {
    return type.name;
  }
}

enum BasketType {
  Monthly,
  Weekly,
  Anually;

  factory BasketType.fromJson(String type) {
    switch (type) {
      case 'Monthly':
        return BasketType.Monthly;
      case 'Weekly':
        return BasketType.Weekly;
      case 'Anually':
        return BasketType.Anually;
      default:
        return BasketType.Monthly;
    }
  }
}
