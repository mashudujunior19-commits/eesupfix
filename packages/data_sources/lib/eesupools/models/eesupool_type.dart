import 'package:freezed_annotation/freezed_annotation.dart';

class EESUpoolTypeConverter implements JsonConverter<EESUpoolType, String> {
  const EESUpoolTypeConverter();

  @override
  EESUpoolType fromJson(String json) {
    return EESUpoolType.fromString(json);
  }

  @override
  String toJson(EESUpoolType object) {
    return object.toString();
  }
}

enum EESUpoolType {
  trade,
  Kasi,
  interestGroup;

  @override
  String toString() {
    switch (this) {
      case EESUpoolType.trade:
        return 'Trade';
      case EESUpoolType.Kasi:
        return 'Kasi';
      case EESUpoolType.interestGroup:
        return 'Interest Group';
      default:
        return 'Trade';
    }
  }

  factory EESUpoolType.fromString(String value) {
    switch (value) {
      case 'Trade':
        return EESUpoolType.trade;
      case 'Kasi':
        return EESUpoolType.Kasi;
      case 'Interest Group':
        return EESUpoolType.interestGroup;
      default:
        return EESUpoolType.trade;
    }
  }
}
