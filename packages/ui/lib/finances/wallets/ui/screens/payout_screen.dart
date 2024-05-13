import 'package:auto_route/auto_route.dart';
import 'package:data/finance/models/wallet.dart';
import 'package:ui/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/core/extensions/sizedbox_ext.dart';
import 'package:ui/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PayoutScreen extends StatelessWidget {
  PayoutScreen({super.key, required this.wallet});
  final Wallet wallet;
  final bankController = TextEditingController();
  final accountNumberController = TextEditingController();
  final branchCodeController = TextEditingController();
  final accountNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Request payout'),
        ),
        body: Container(
          decoration: context.bgImage,
          child: Container(
            color: Colors.white.withOpacity(.4),
            child: ListView(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: 400,
              ),
              children: [
                EESUpTextFormField(
                  label: 'Available balance',
                  readOnly: true,
                  initialValue: 'R ${wallet.balance.toStringAsFixed(2)}',
                ),
                EESUpTextFormField(
                  label: 'Bank',
                  hintText: 'Capitec, Absa, First National bank...',
                  controller: bankController,
                ),
                EESUpTextFormField(
                  label: 'Account holder',
                  hintText: 'Savings, Cheque...',
                  controller: accountNameController,
                ),
                EESUpTextFormField(
                  label: 'Account number',
                  hintText: 'John Doe',
                  type: TextInputType.number,
                  controller: accountNumberController,
                ),
                EESUpTextFormField(
                  label: 'Branch code',
                  type: TextInputType.number,
                  hintText: '250655',
                  controller: branchCodeController,
                ),
                EESUpTextFormField(
                  label: 'Account',
                  hintText: 'Savings, Cheque...',
                  controller: accountNameController,
                ),
                25.sH,
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
