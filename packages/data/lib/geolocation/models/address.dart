// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class Address with _$Address {
  factory Address({
    @JsonKey(includeToJson: false) int? id,
    @JsonKey(name: 'area_id') int? areaId,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'recipient_name') required String recipientName,
    @JsonKey(name: 'recipient_phone') required String recipientPhone,
    @JsonKey(name: 'street_address') required String streetAddress,
    @JsonKey(name: 'building_name') String? buildingName,
    required String type,
    required String province,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'created_at', includeToJson: false)
    required DateTime createdAt,
    @JsonKey(name: 'is_primary') @Default(false) bool isPrimary,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

class AddressConverter implements JsonConverter<Address, Map<String, dynamic>> {
  const AddressConverter();

  @override
  Address fromJson(Map<String, dynamic> json) {
    return Address.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Address instance) => instance.toJson();
}
