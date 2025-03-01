// ignore_for_file: constant_identifier_names
import 'package:freezed_annotation/freezed_annotation.dart';

class EESUpoolLevelConverter implements JsonConverter<EESUpoolLevel, String> {
  const EESUpoolLevelConverter();
  @override
  EESUpoolLevel fromJson(String json) {
    return EESUpoolLevel.fromString(json);
  }

  @override
  String toJson(EESUpoolLevel object) {
    return object.name;
  }
}

enum EESUpoolLevel {
  National,
  Regional,
  Township,
  kasi,
  Street;

  factory EESUpoolLevel.fromString(String level) {
    switch (level.trim()) {
      case 'National':
        return EESUpoolLevel.National;
      case 'Regional':
        return EESUpoolLevel.Regional;
      case 'Township':
        return EESUpoolLevel.Township;
      case 'Kasi':
        return EESUpoolLevel.kasi;
      case 'Street':
        return EESUpoolLevel.Street;
      default:
        throw Exception(
          'Unknown EESUpoolLevel: $level',
        );
    }
  }

  @override
  String toString() {
    switch (this) {
      case EESUpoolLevel.National:
        return 'National';
      case EESUpoolLevel.Regional:
        return 'Regional';
      case EESUpoolLevel.Township:
        return 'Township';
      case EESUpoolLevel.kasi:
        return 'Kasi';
      case EESUpoolLevel.Street:
        return 'Street';
      }
  }

  EESUpoolLevel? get child => {
        EESUpoolLevel.National: EESUpoolLevel.Regional,
        EESUpoolLevel.Regional: EESUpoolLevel.Township,
        EESUpoolLevel.Township: EESUpoolLevel.kasi,
        EESUpoolLevel.kasi: EESUpoolLevel.Street,
        EESUpoolLevel.Street: null,
      }[this];

  EESUpoolLevel? get parent => {
        EESUpoolLevel.National: null,
        EESUpoolLevel.Regional: EESUpoolLevel.National,
        EESUpoolLevel.Township: EESUpoolLevel.Regional,
        EESUpoolLevel.kasi: EESUpoolLevel.Township,
        EESUpoolLevel.Street: EESUpoolLevel.kasi,
      }[this];

  List<EESUpoolLevel> lowerLevels() {
    switch (this) {
      case EESUpoolLevel.National:
        return [
          EESUpoolLevel.Regional,
          EESUpoolLevel.Township,
          EESUpoolLevel.kasi,
          EESUpoolLevel.Street
        ];
      case EESUpoolLevel.Regional:
        return [
          EESUpoolLevel.Township,
          EESUpoolLevel.kasi,
          EESUpoolLevel.Street
        ];
      case EESUpoolLevel.Township:
        return [EESUpoolLevel.kasi, EESUpoolLevel.Street];
      case EESUpoolLevel.kasi:
        return [EESUpoolLevel.Street];
      case EESUpoolLevel.Street:
        return [];
      }
  }

  // List<EESUpoolLevel> get higherLevels => {
  //       EESUpoolLevel.National: [],
  //       EESUpoolLevel.Regional: [
  //         EESUpoolLevel.National,
  //       ],
  //       EESUpoolLevel.Township: [
  //         EESUpoolLevel.National,
  //         EESUpoolLevel.Regional,
  //       ],
  //       EESUpoolLevel.kasi: [
  //         EESUpoolLevel.National,
  //         EESUpoolLevel.Regional,
  //         EESUpoolLevel.Township,
  //       ],
  //       EESUpoolLevel.Street: [
  //         EESUpoolLevel.National,
  //         EESUpoolLevel.Regional,
  //         EESUpoolLevel.Township,
  //         EESUpoolLevel.kasi,
  //       ],
  //     }[this]!;
}
