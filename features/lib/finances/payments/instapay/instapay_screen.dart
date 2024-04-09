import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:instapay_flutter/data/merchant_transaction.dart';
import 'package:instapay_flutter/presentation/instapay.dart';

@RoutePage()
// ignore: must_be_immutable
class InstapayScreen extends StatelessWidget {
  const InstapayScreen({super.key, required this.transaction});

  final MerchantTransaction transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: InstapayFlutter(
        transaction: transaction,
        onUrlChange: (String? url) {
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

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: BackButton(
        onPressed: () {
          Navigator.of(context).pop(false);
        },
      ),
      title: const Text("Instapay"),
    );
  }
}
