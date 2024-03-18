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
        leading: const BackButton(),
      ),
      body: InstapayFlutter(
        transaction:transaction,
      ),
    );
  }
}
