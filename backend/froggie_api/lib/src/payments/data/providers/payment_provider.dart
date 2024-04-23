import 'package:eesup_dart_frog/src/payments/data/models/ozow_transaction.dart';

abstract class PaymentGatewayProvider {
  Future<OzowTransaction?> fetchOzowTransaction({
    required String reference,
    required bool isTest,
  });
  Future<bool> confirmOnlinePayment({
    required int reference,
    required bool isConfirmed,
  });
}