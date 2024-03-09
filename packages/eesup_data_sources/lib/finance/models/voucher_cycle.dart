import 'package:json_annotation/json_annotation.dart';

enum VoucherCycle {
  weekly,
  monthly,
  onceOff;

  factory VoucherCycle.fromJson(Map<String, dynamic> json) {
    switch (json['cycle']) {
      case 'Weekly':
        return VoucherCycle.weekly;
      case 'Monthly':
        return VoucherCycle.monthly;
      case 'Once-off':
        return VoucherCycle.onceOff;
      default:
        throw Exception('Invalid cycle');
    }
  }

  @override
  String toString() {
    switch (this) {
      case VoucherCycle.weekly:
        return 'Weekly';
      case VoucherCycle.monthly:
        return 'Monthly';
      case VoucherCycle.onceOff:
        return 'Once-off';
    }
  }
}


class VoucherCycleConverter implements JsonConverter<VoucherCycle, String> {
  const VoucherCycleConverter();

  @override
  VoucherCycle fromJson(String json) {
    switch (json) {
      case 'Weekly':
        return VoucherCycle.weekly;
      case 'Monthly':
        return VoucherCycle.monthly;
      case 'Once-off':
        return VoucherCycle.onceOff;
      default:
        throw Exception('Invalid cycle');
    }
  }

  @override
  String toJson(VoucherCycle object) {
    switch (object) {
      case VoucherCycle.weekly:
        return 'Weekly';
      case VoucherCycle.monthly:
        return 'Monthly';
      case VoucherCycle.onceOff:
        return 'Once-off';
    }
  }
}