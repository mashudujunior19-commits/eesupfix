// ignore_for_file: use_build_context_synchronously
import 'package:auto_route/auto_route.dart';
import 'package:features/core/extensions/bg_image_deco_ext.dart';
import 'package:features/core/extensions/context_alerts_ext.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/widgets/eesup_form_field.dart';
import 'package:features/finances/wallets/ui/widgets/search_transfer_beneficiary_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:data_sources/finance/models/wallet.dart';

@RoutePage()
class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key, required this.wallet});
  final Wallet wallet;

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _amountController = TextEditingController();
  final _myRefController = TextEditingController();
  final _beneficiaryRefController = TextEditingController();
  dynamic _beneficiary;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          centerTitle: true,
          title: const Text('Transfer'),
        ),
        body: Container(
          decoration: context.bgImage,
          child: Container(
            color: Colors.white.withOpacity(.5),
            child: ListView(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 200),
              children: [
                EESUpTextFormField(
                  label: 'From',
                  readOnly: false,
                  type: TextInputType.number,
                  controller: TextEditingController(
                    text:
                        '${widget.wallet.description} - R${widget.wallet.balance.toStringAsFixed(2)}',
                  ),
                ),
                EESUpTextFormField(
                  label: 'To',
                  readOnly: true,
                  isRequired: true,
                  onTap: () {
                    searchTransferBeneficiaryDialog(context).then((value) {
                      if (value != null) {
                        _beneficiary = value;
                        setState(() {});
                      }
                    });
                  },
                  hintText: 'Search beneficiary..',
                  controller: TextEditingController(
                    text: _beneficiary == null
                        ? null
                        : '${_beneficiary?['full_name'] ?? '~'} -> ${_beneficiary['description']} wallet',
                  ),
                ),
                EESUpTextFormField(
                  label: 'My Reference',
                  hintText: 'My reference',
                  type: TextInputType.text,
                  controller: _myRefController,
                  isRequired: true,
                ),
                EESUpTextFormField(
                  label: 'Beneficiary Reference',
                  hintText: 'Beneficiary reference',
                  type: TextInputType.text,
                  controller: _beneficiaryRefController,
                  isRequired: true,
                ),
                EESUpTextFormField(
                  label: 'Amount',
                  hintText: '50.00',
                  type: TextInputType.number,
                  controller: _amountController,
                  isRequired: true,
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    if (_beneficiary == null) {
                      context.snackBarError('Please select a beneficiary');
                      return;
                    }

                    if (_myRefController.text.isEmpty) {
                      context.snackBarError('Please enter your reference');
                      return;
                    }

                    if (_beneficiaryRefController.text.isEmpty) {
                      context
                          .snackBarError('Please enter beneficiary reference');
                      return;
                    }

                    if (_amountController.text.isEmpty) {
                      context.snackBarError('Please enter an amount');
                      return;
                    }

                    final amount = double.tryParse(_amountController.text);

                    if (amount == null) {
                      context.snackBarError('Please enter a valid amount');
                      return;
                    }

                    if (amount < 1) {
                      context.snackBarError('Please enter a valid amount');
                      return;
                    }

                    final toWallet = _beneficiary['wallet_id'];

                    if (toWallet == null) {
                      context
                          .snackBarError('Please select a beneficiary wallet');
                      return;
                    }

                    context.showAlertDialog(
                        'Confirm transfer',
                        'Are you sure you want to transfer R${amount.toStringAsFixed(2)} '
                            'to ${_beneficiary['full_name']}?',
                        onNegative: () {},
                        negativeColor:
                            context.colorScheme.primary.withOpacity(.5),
                        positiveColor: context.colorScheme.primary,
                        positiveText: 'Transfer',
                        negativeText: 'Cancel', onPositive: () async {
                      // context.loaderOverlay.show();
                      // final results = await ref
                      //     .read(walletRepoProvider)
                      //     .transferFundsWalletToWallet(
                      //       fromWalletId: widget.wallet.id,
                      //       toWalletId: toWallet,
                      //       amount: amount,
                      //       toRef: _beneficiaryRefController.text,
                      //       fromRef: _myRefController.text,
                      //     );
                      // context.loaderOverlay.hide();

                      // results.fold((l) {
                      //   context.snackBarError(l.message);
                      // }, (r) {
                      //   if (r != null) {
                      //     context.snackBarSuccess('Transfer successful');
                      //     Navigator.pop(context);
                      //   } else {
                      //     context.snackBarError('Transfer failed');
                      //   }
                      // });
                    });
                  },
                  child: const Text('Transfer'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> transfer() async {
    FocusScope.of(context).unfocus();
    if (_beneficiary == null) {
      context.snackBarError('Please select a beneficiary');

      return;
    }

    if (_myRefController.text.isEmpty) {
      context.snackBarError('Please enter your reference');
      return;
    }

    if (_beneficiaryRefController.text.isEmpty) {
      context.snackBarError('Please enter beneficiary reference');
      return;
    }

    if (_amountController.text.isEmpty) {
      context.snackBarError('Please enter an amount');
      return;
    }

    final amount = double.tryParse(_amountController.text);

    if (amount == null) {
      return;
    }

    double balance = widget.wallet.balance;

    if (balance <= 0) {
      context.snackBarError('Insufficient funds');
      return;
    }

    if (balance < amount) {
      context.snackBarError('Insufficient funds');
      return;
    }

    //final result = await _confirmationDialog(context, amount);

    // if (result == true) {
    //   ref.read(busyIndicatorProvider.notifier).toggleBusy(true);
    //   final success = await ref.read(walletRepositoryProvider).transfer(
    //         fromWalletId: widget.wallet.walletId,
    //         toWalletId: _beneficiary!.walletId,
    //         amount: amount,
    //         myReference: _myRefController.text,
    //         beneficiaryReference: _beneficiaryRefController.text,
    //       );
    //   ref.read(busyIndicatorProvider.notifier).toggleBusy(false);

    //   if (success) {
    //     showSnackBar(
    //       context: context,
    //       type: SnackBarType.success,
    //       message: 'Transfer successful',
    //     );
    //     //   ref.invalidate(userWalletsProvider);
    //     ref.invalidate(walletTransactions(widget.wallet.walletId));
    //     Navigator.of(context).pop(true);
    //     Navigator.of(context).pop(true);
    //   } else {
    //     showSnackBar(
    //       context: context,
    //       type: SnackBarType.error,
    //       message: 'Transfer failed',
    //     );
    //   }
  }

  Future<Object?> _confirmationDialog(BuildContext context, double? amount) {
    return showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ClassicGeneralDialogWidget(
          titleText: 'Confirm transfer',
          contentText:
              'Are you sure you want to transfer R${amount!.toStringAsFixed(2)} to ${_beneficiary?['full_name']}?',
          negativeText: 'Cancel',
          positiveText: 'Confirm',
          onPositiveClick: () {
            Navigator.of(context).pop(true);
          },
          onNegativeClick: () {
            Navigator.of(context).pop(false);
          },
        );
      },
      animationType: DialogTransitionType.slideFromBottom,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(seconds: 1),
    );
  }
}
