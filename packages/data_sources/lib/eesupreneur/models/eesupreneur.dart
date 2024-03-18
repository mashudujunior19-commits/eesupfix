// ignore_for_file: invalid_annotation_target

import 'package:data_sources/geolocation/models/address.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'eesupreneur.freezed.dart';
part 'eesupreneur.g.dart';

@freezed
class EESUpreneur with _$EESUpreneur {
  const factory EESUpreneur({
    @JsonKey(includeToJson: false) required String id,
    @JsonKey(name: 'owner_name', includeToJson: false) String? ownerName,
    required String name,
    String? description,
    @JsonKey(name: 'owner_id', includeToJson: false) required String ownerId,
    @JsonKey(name: 'created_at', includeToJson: false) DateTime? createdAt,
    @JsonKey(name: 'delivery_fee') double? deliveryFee,
    @JsonKey(name: 'is_hidden') bool? isHidden,
    @JsonKey(name: 'is_active') bool? isActive,
    //@JsonKey(name: 'schedule') required List<DaySchedule> daySchedule,
    @JsonKey(includeToJson: false) @AddressConverter() Address? address,
    @JsonKey(includeToJson: false) double? distance,
  }) = _EESUpreneur;

  factory EESUpreneur.fromJson(Map<String, dynamic> json) =>
      _$EESUpreneurFromJson(json);
}

class EESUpreneurConverter
    implements JsonConverter<EESUpreneur, Map<String, dynamic>> {
  const EESUpreneurConverter();

  @override
  EESUpreneur fromJson(Map<String, dynamic> json) {
    return EESUpreneur.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(EESUpreneur eesupool) {
    return eesupool.toJson();
  }
}
