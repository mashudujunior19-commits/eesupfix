import 'package:freezed_annotation/freezed_annotation.dart';

part 'hamper_banner.freezed.dart';
part 'hamper_banner.g.dart';

@freezed
class HamperBanner with _$HamperBanner {
  const factory HamperBanner({
    required int id,
    @HamperContentConverter() required List<HamperContent> content,
    required String hamperCode,
    @JsonKey(name: 'profit_percentage') required double profitPercentage,
    required double value,
    @JsonKey(name: 'profit_allocation_id') required int profitAllocationId,
  }) = _HamperBanner;

  factory HamperBanner.fromJson(Map<String, dynamic> json) {
    print("Raw JSON inside fromJson: $json");

    final hamperDetails = json['hamper_details'] as Map<String, dynamic>? ?? {};
    print("Extracted hamperDetails: $hamperDetails");

    final profitPercentage = hamperDetails['profit_percentage'];
    final value = hamperDetails['value'];
    final profitAllocationId = hamperDetails['profit_allocation_id'];

    print("profit_percentage before parsing: $profitPercentage");
    print("value before parsing: $value");
    print("profit_allocation_id before parsing: $profitAllocationId");

    return HamperBanner(
      id: json['id'] as int,
      content: (json['content'] as List<dynamic>?)?.map((e) {
            print("Parsing content item: $e");
            return HamperContent.fromJson(e as Map<String, dynamic>);
          }).toList() ??
          [],
      hamperCode: hamperDetails['code'] as String? ?? '',
      profitPercentage: profitPercentage != null
          ? (profitPercentage is num ? profitPercentage.toDouble() : 0.0)
          : 0.0,
      value: value != null ? (value is num ? value.toDouble() : 0.0) : 0.0,
      profitAllocationId: profitAllocationId ?? 0,
    );
  }
}

@freezed
class HamperContent with _$HamperContent {
  const factory HamperContent({
    required int orderNumber,
    required String baseImage,
    required String gif1,
    required String gif2,
    required String type,
  }) = _HamperContent;

  factory HamperContent.fromJson(Map<String, dynamic> json) =>
      _$HamperContentFromJson(json);
}

class HamperContentConverter
    implements JsonConverter<List<HamperContent>, List<dynamic>> {
  const HamperContentConverter();

  @override
  List<HamperContent> fromJson(List<dynamic> json) {
    return json
        .map((e) => HamperContent.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  List<dynamic> toJson(List<HamperContent> object) {
    return object.map((e) => e.toJson()).toList();
  }
}
