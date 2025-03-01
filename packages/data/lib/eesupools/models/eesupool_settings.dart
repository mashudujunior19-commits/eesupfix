// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eesupool_settings.freezed.dart';
part 'eesupool_settings.g.dart';

@freezed
abstract class EESUpoolSettings with _$EESUpoolSettings {
  const EESUpoolSettings._();

  const factory EESUpoolSettings({
    @JsonKey(includeToJson: false) required int id,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'minimum_order_value') double? minimumOrderValue,
    @JsonKey(name: 'admin_order_count') int? adminOrderCount,
    @JsonKey(name: 'daily_closing_order_time') String? dailyClosingOrderTime,
    @JsonKey(name: 'eesupool_id') required int eesupoolId,
    @JsonKey(name: 'user_count') num? userCount,
  }) = _EESUpoolSettings;

  factory EESUpoolSettings.fromJson(Map<String, dynamic> json) =>
      _$EESUpoolSettingsFromJson(json);

  double get safeMinimumOrderValue => minimumOrderValue ?? 0;
  int get safeAdminOrderCount => adminOrderCount ?? 0;
  double get safeUserCount => (userCount)?.toDouble() ?? 0;
}
