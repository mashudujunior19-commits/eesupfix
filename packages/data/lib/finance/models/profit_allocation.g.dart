// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profit_allocation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfitAllocationImpl _$$ProfitAllocationImplFromJson(
        Map<String, dynamic> json) =>
    _$ProfitAllocationImpl(
      cia: (json['cia'] as num).toDouble(),
      cwa: (json['cwa'] as num).toDouble(),
      eia: (json['eia'] as num).toDouble(),
      crc: (json['crc'] as num).toDouble(),
      csa: (json['csa'] as num).toDouble(),
      daa: (json['daa'] as num).toDouble(),
      id: (json['id'] as num).toInt(),
      cfv: (json['cfv'] as num).toDouble(),
    );

Map<String, dynamic> _$$ProfitAllocationImplToJson(
        _$ProfitAllocationImpl instance) =>
    <String, dynamic>{
      'cia': instance.cia,
      'cwa': instance.cwa,
      'eia': instance.eia,
      'crc': instance.crc,
      'csa': instance.csa,
      'daa': instance.daa,
      'id': instance.id,
      'cfv': instance.cfv,
    };
