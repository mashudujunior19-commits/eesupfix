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

  // factory HamperBanner.fromJson(Map<String, dynamic> json) => HamperBanner(

  //       id: json['id'] as int,
  //       content: (json['content'] as List<dynamic>?)
  //               ?.map((e) => HamperContent.fromJson(e as Map<String, dynamic>))
  //               .toList() ??
  //           [],
  //       hamperCode: json['hamper_details']['code'] as String? ?? '',
  //       profitPercentage:
  //           (json['hamper_details']['profit_percentage'] as num?)?.toDouble() ??
  //               0.0,
  //       value: (json['hamper_details']['value'] as num?)?.toDouble() ?? 0.0,
  //       profitAllocationId:
  //           json['hamper_details']['profit_allocation_id'] as int? ?? 0,
  //     );
  factory HamperBanner.fromJson(Map<String, dynamic> json) {
    print("Raw JSON inside fromJson: $json");

    final hamperDetails = json['hamper_details'] as Map<String, dynamic>? ?? {};
    print("Extracted hamperDetails: $hamperDetails");

    print(
        "profit_percentage before parsing: ${hamperDetails['profit_percentage']}");
    print("value before parsing: ${hamperDetails['value']}");
    print(
        "profit_allocation_id before parsing: ${hamperDetails['profit_allocation_id']}");

    return HamperBanner(
      id: json['id'] as int,
      content: (json['content'] as List<dynamic>?)?.map((e) {
            print("Parsing content item: $e");
            return HamperContent.fromJson(e as Map<String, dynamic>);
          }).toList() ??
          [],
      hamperCode: hamperDetails['code'] as String? ?? '',
      profitPercentage:
          (hamperDetails['profit_percentage'] as num?)?.toDouble() ?? 0.0,
      value: (hamperDetails['value'] as num?)?.toDouble() ?? 0.0,
      profitAllocationId: (hamperDetails['profit_allocation_id'] as int?) ?? 0,
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
