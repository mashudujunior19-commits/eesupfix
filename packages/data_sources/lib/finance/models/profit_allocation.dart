import 'package:data_sources/auth/models/user_role.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profit_allocation.freezed.dart';
part 'profit_allocation.g.dart';

@freezed
class ProfitAllocation with _$ProfitAllocation {
  const factory ProfitAllocation({
    required double cia,
    required double cwa,
    required double eia,
    required double crc,
    required double csa,
    required double daa,
    @UserRoleConverter() required List<UserRole> roles,
    required int id,
    required double cfv,
  }) = _ProfitAllocation;

  factory ProfitAllocation.fromJson(Map<String, dynamic> json) =>
      _$ProfitAllocationFromJson(json);
}
