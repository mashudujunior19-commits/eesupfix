import 'package:auto_route/auto_route.dart';
import 'package:data/finance/models/payout_request.dart';
import 'package:data/finance/models/wallet.dart';
import 'package:data/finance/repository/wallets_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';
import 'package:data/utils/double_ext.dart';

@RoutePage()
class PayoutScreen extends StatelessWidget {
  PayoutScreen({super.key, required this.wallet});
  final Wallet wallet;
  final bankController = TextEditingController();
  final accountNumberController = TextEditingController();
  final branchCodeController = TextEditingController();
  final accountNameController = TextEditingController();
  final amountController = TextEditingController();
  final accHolderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  initialValue: 'R ${wallet.balance.toRounded()}',
                ),
                EESUpTextFormField(
                  label: 'Amount',
                  hintText: 'R100',
                  type: TextInputType.number,
                  controller: amountController,
                ),
                EESUpTextFormField(
                  label: 'Bank',
                  hintText: 'Capitec, Absa, First National bank...',
                  controller: bankController,
                ),
                EESUpTextFormField(
                  label: 'Account',
                  hintText: 'Savings, Cheque...',
                  controller: accountNameController,
                ),
                EESUpTextFormField(
                  label: 'Account number',
                  hintText: '15323443223',
                  type: TextInputType.number,
                  controller: accountNumberController,
                ),
                EESUpTextFormField(
                  label: 'Account Holder',
                  hintText: 'John Smith',
                  controller: accHolderController,
                ),
                EESUpTextFormField(
                  label: 'Branch code',
                  hintText: '250655',
                  controller: branchCodeController,
                ),
                25.sH,
                ElevatedButton(
                  onPressed: () async {
                    if (bankController.text.isEmpty ||
                        accountNumberController.text.isEmpty ||
                        branchCodeController.text.isEmpty ||
                        accountNameController.text.isEmpty ||
                        amountController.text.isEmpty ||
                        accHolderController.text.isEmpty) {
                      context.snackBarError(
                        "Please make sure that all the fields are filled.",
                      );
                      return;
                    }

                    final amount = double.parse(amountController.text);

                    if (amount > wallet.balance) {
                      context.snackBarError(
                        'Your withdrawal amount cannot exceed your available balance',
                      );
                      return;
                    }

                    context.loaderOverlay.show();
                    final results = await context
                        .read<WalletsRepository>()
                        .createPayoutRequest(
                          PayoutRequest(
                            createdAt: DateTime.now(),
                            bank: bankController.text,
                            accNumber: accountNumberController.text,
                            accName: accountNameController.text,
                            branchCode: branchCodeController.text,
                            id: 0,
                            accHolder: accHolderController.text,
                            amount: double.parse(amountController.text),
                            walletId: wallet.id,
                          ),
                        );
                    context.loaderOverlay.hide();

                    results.fold((l) {
                      context.snackBarError(l.message);
                    }, (r) {
                      if (r) {
                        context.snackBarSuccess(
                          'Payout was submited, it will be proccessed to and then paid out to your nominated bank.',
                        );
                        Navigator.of(context).pop(true);
                      } else {
                        context.snackBarError(
                          'Payout form could not be submited.',
                        );
                      }
                    });
                  },
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
