// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eesupool_settings.freezed.dart';
part 'eesupool_settings.g.dart';

// @freezed
// class EESUpoolSettings with _$EESUpoolSettings {
//   const EESUpoolSettings._();

//   const factory EESUpoolSettings({
//     @JsonKey(includeToJson: false) required int id,
//     @JsonKey(name: 'created_at') required DateTime createdAt,
//     @JsonKey(name: 'minimum_order_value') double? minimumOrderValue,
//     @JsonKey(name: 'admin_order_count') int? adminOrderCount,
//     @JsonKey(name: 'daily_closing_order_time') String? dailyClosingOrderTime,
//     @JsonKey(name: 'eesupool_id') required int eesupoolId,
//     @JsonKey(name: 'user_count') num? userCount,
//   }) = _EESUpoolSettings;

//   factory EESUpoolSettings.fromJson(Map<String, dynamic> json) =>
//       _$EESUpoolSettingsFromJson(json);

//   double get safeMinimumOrderValue => minimumOrderValue ?? 0;
//   int get safeAdminOrderCount => adminOrderCount ?? 0;
//   double get safeUserCount => (userCount)?.toDouble() ?? 0;
// }

@freezed
class EESUpoolSettings with _$EESUpoolSettings {
  const EESUpoolSettings._(); // Private constructor for computed properties

  const factory EESUpoolSettings({
    @JsonKey(includeToJson: false) required int id,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'minimum_order_value') double? minimumOrderValue,
    @JsonKey(name: 'admin_order_count') int? adminOrderCount,
    @JsonKey(name: 'daily_closing_order_time') String? dailyClosingOrderTime,
    @JsonKey(name: 'eesupool_id') required int eesupoolId,
    @JsonKey(name: 'user_count', fromJson: _userCountFromJson)
    required num userCount,
  }) = _EESUpoolSettings;

  factory EESUpoolSettings.fromJson(Map<String, dynamic> json) =>
      _$EESUpoolSettingsFromJson(json);

  double get safeMinimumOrderValue => minimumOrderValue ?? 0;
  int get safeAdminOrderCount => adminOrderCount ?? 0;
  double get safeUserCount => userCount.toDouble();

  // Custom fromJson for userCount to ensure no null value
  static num _userCountFromJson(dynamic json) {
    // Ensure that null values are converted to 0.0
    if (json == null) return 0.0;
    if (json is num) return json.toDouble(); // Ensure it's a double
    return 0.0;
  }
}
