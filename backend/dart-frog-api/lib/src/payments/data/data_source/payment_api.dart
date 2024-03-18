import 'package:eesup_dart_frog/src/payments/data/models/instapay_status.dart';
import 'package:eesup_dart_frog/src/payments/data/models/ozow_status.dart';
import 'package:eesup_dart_frog/src/payments/data/models/ozow_transaction.dart';

abstract class PaymentApi {
  Future<OzowTransaction?> fetchOzowTransaction({
    required String reference,
    required bool isTest,
  });

  Future<bool> confirmOzowEft({
    required int orderId,
    required OzowStatus status,
    required String type,
  });

    Future<bool> confirmInstapayEft({
    required int orderId,
    required InstapayStatus status,
    required String type,
  });
}
