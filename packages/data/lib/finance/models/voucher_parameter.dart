// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'voucher_parameter.freezed.dart';
part 'voucher_parameter.g.dart';

@freezed
abstract class VoucherParameter with _$VoucherParameter {
  const factory VoucherParameter({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'period') required int period,
    @JsonKey(name: 'interest') required double interest,
    @JsonKey(name: 'minimum_value') required double minimumValue,
  }) = _VoucherParameter;

  factory VoucherParameter.fromJson(Map<String, dynamic> json) =>
      _$VoucherParameterFromJson(json);
}
