import 'package:freezed_annotation/freezed_annotation.dart';

enum PaymentMethod {
  ozow,
  instapay,
  retailWallet,
  splitOzowRetailWalletPayment,
  splitInstapayRetailWalletPayment;

  @override
  String toString() {
    switch (this) {
      case PaymentMethod.ozow:
        return 'Ozow';
      case PaymentMethod.instapay:
        return 'Instapay';
      case PaymentMethod.retailWallet:
        return 'Retail wallet';
      case PaymentMethod.splitOzowRetailWalletPayment:
        return 'Split-Ozow & Retail wallet';
      case PaymentMethod.splitInstapayRetailWalletPayment:
        return 'Split-Instapay & Retail wallet';

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
      case 'Split-Instapay & Retail wallet':
        return PaymentMethod.splitInstapayRetailWalletPayment;
      default:
        return PaymentMethod.retailWallet;
    }
  }

  double? fee() {
    switch (this) {
      case PaymentMethod.ozow:
        return null;
      case PaymentMethod.retailWallet:
        return null;
      case PaymentMethod.splitOzowRetailWalletPayment:
        return null;
      case PaymentMethod.splitInstapayRetailWalletPayment:
        return 2.00;
      case PaymentMethod.instapay:
        return 2.00;
      default:
        return null;
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
