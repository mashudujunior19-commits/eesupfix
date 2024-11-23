// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'hamper_banner.freezed.dart';
part 'hamper_banner.g.dart';

@freezed
class HamperBanner with _$HamperBanner {
  const factory HamperBanner({
    required int id,
    @HamperContentConverter() required List<HamperContent> content,
  }) = _HamperBanner;

  factory HamperBanner.fromJson(Map<String, dynamic> json) =>
      _$HamperBannerFromJson(json);
}

class HamperContentConverter
    implements JsonConverter<HamperContent, Map<String, dynamic>> {
  const HamperContentConverter();

  @override
  HamperContent fromJson(Map<String, dynamic> json) {
    return HamperContent.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(HamperContent object) {
    return object.toJson();
  }
}

@freezed
class HamperContent with _$HamperContent {
  const factory HamperContent({
    required String type,
    @JsonKey(name: 'order_number') required int orderNumber,
    @JsonKey(name: 'base_image') required String baseImage,
    required String gif1,
    required String gif2,
  }) = _HamperContent;

  factory HamperContent.fromJson(Map<String, dynamic> json) =>
      _$HamperContentFromJson(json);
}
