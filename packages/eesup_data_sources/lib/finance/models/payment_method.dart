import 'package:freezed_annotation/freezed_annotation.dart';

enum PaymentMethod {
  ozow,
  retailWallet,
  splitOzowRetailWalletPayment;

  @override
  String toString() {
    switch (this) {
      case PaymentMethod.ozow:
        return 'Ozow';
      case PaymentMethod.retailWallet:
        return 'Retail wallet';
      case PaymentMethod.splitOzowRetailWalletPayment:
        return 'Split-Ozow & Retail wallet';
      default:
        return 'Retail wallet';
    }
  }

  factory PaymentMethod.fromString(String key) {
    switch (key) {
      case 'Ozow':
        return PaymentMethod.ozow;
      case 'Retail wallet':
        return PaymentMethod.retailWallet;
      case 'Split-Ozow & Retail wallet':
        return PaymentMethod.splitOzowRetailWalletPayment;
      default:
        return PaymentMethod.retailWallet;
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
