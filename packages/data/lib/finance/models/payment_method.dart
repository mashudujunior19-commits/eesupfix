import 'package:freezed_annotation/freezed_annotation.dart';

enum PaymentMethod {
  ozow,
  yoco,
  retailWallet,
  splitOzow,
  splitYoco;

  @override
  String toString() {
    switch (this) {
      case PaymentMethod.ozow:
        return 'Ozow';
      case PaymentMethod.yoco:
        return 'Yoco';
      case PaymentMethod.retailWallet:
        return 'Retail wallet';
      case PaymentMethod.splitOzow:
        return 'Split-Ozow';
      case PaymentMethod.splitYoco:
        return 'Split-Yoco';
    }
  }

  factory PaymentMethod.fromString(String key) {
    switch (key) {
      case 'Ozow':
        return PaymentMethod.ozow;
      case 'Yoco':
        return PaymentMethod.yoco;
      case 'Retail wallet':
        return PaymentMethod.retailWallet;
      case 'Split-Ozow':
        return PaymentMethod.splitOzow;
      case 'Split-Yoco':
        return PaymentMethod.splitYoco;
      default:
        return PaymentMethod.retailWallet;
    }
  }

  PaymentMethod? feeId() {
    switch (this) {
      case PaymentMethod.ozow:
        return PaymentMethod.ozow;
      case PaymentMethod.retailWallet:
        return null;
      case PaymentMethod.splitOzow:
        return PaymentMethod.ozow;
      case PaymentMethod.yoco:
        return PaymentMethod.yoco;
      case PaymentMethod.splitYoco:
        return PaymentMethod.yoco;
    }
  }
}

class PaymentMethodConverter implements JsonConverter<PaymentMethod, String> {
  const PaymentMethodConverter();

  @override
  PaymentMethod fromJson(String status) {
    return PaymentMethod.fromString(status);
  }

  @override
  String toJson(PaymentMethod status) {
    return status.toString();
  }
}
