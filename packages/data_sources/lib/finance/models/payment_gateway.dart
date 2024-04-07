// ignore_for_file: invalid_annotation_target

import 'package:data_sources/finance/models/payment_method.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_gateway.freezed.dart';
part 'payment_gateway.g.dart';

@freezed
class PaymentGateway with _$PaymentGateway {
  const factory PaymentGateway({
    @PaymentMethodConverter() required PaymentMethod id,
    @JsonKey(name: 'is_active') required bool isActive,
    required double fee,
  }) = _PaymentGateway;

  factory PaymentGateway.fromJson(Map<String, dynamic> json) =>
      _$PaymentGatewayFromJson(json);
}
