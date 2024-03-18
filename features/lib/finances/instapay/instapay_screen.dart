import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:instapay_flutter/data/merchant_transaction.dart';
import 'package:instapay_flutter/presentation/instapay.dart';

@RoutePage()
class InstapayScreen extends StatelessWidget {
  const InstapayScreen({super.key, required this.transaction});
  final MerchantTransaction transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ),
      body: InstapayFlutter(
        transaction: transaction,
        onUrlChange: (String? url) {
          // print("33333333333333355555555555555555555555555555555: $url");
          if (url != null) {
            if (url.contains('payment_success')) {
              Navigator.of(context).pop(true);
            } else if (url.contains('payment_failed')) {
              Navigator.of(context).pop(false);
            }
          }
        },
      ),
    );
  }
}
