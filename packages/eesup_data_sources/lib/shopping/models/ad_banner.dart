// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ad_banner.freezed.dart';
part 'ad_banner.g.dart';

@freezed
class AdBanner with _$AdBanner {
  const factory AdBanner({
    required int id,
    @AdContentConverter() required List<AdContent> content,
  }) = _AdBanner;

  factory AdBanner.fromJson(Map<String, dynamic> json) =>
      _$AdBannerFromJson(json);
}

class AdContentConverter
    implements JsonConverter<AdContent, Map<String, dynamic>> {
  const AdContentConverter();

  @override
  AdContent fromJson(Map<String, dynamic> json) {
    return AdContent.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(AdContent object) {
    return object.toJson();
  }
}

@freezed
class AdContent with _$AdContent {
  const factory AdContent({
    required String url,
    required String type,
    @JsonKey(name: 'order_number') required int orderNumber,
  }) = _AdContent;

  factory AdContent.fromJson(Map<String, dynamic> json) =>
      _$AdContentFromJson(json);
}
