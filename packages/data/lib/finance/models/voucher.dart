// ignore_for_file: invalid_annotation_target

import 'package:data/finance/models/voucher_cycle.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'voucher.freezed.dart';
part 'voucher.g.dart';

@freezed
class Voucher with _$Voucher {
  const factory Voucher({
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'parameter_id') required String parameterId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'balance') required double balance,
    @JsonKey(name: 'value') required double value,
    @JsonKey(name: 'id') int? id,
    @VoucherCycleConverter()
    @JsonKey(name: 'cycle')
    required VoucherCycle cycle,
    required int period,
    @JsonKey(name: 'end_date') required DateTime endDate,
    @JsonKey(name: 'confirmed_at') DateTime? confirmedAt,
  }) = _Voucher;

  factory Voucher.fromJson(Map<String, dynamic> json) =>
      _$VoucherFromJson(json);
}
