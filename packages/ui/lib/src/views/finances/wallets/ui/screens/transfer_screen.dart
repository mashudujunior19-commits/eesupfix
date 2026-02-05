// ignore_for_file: use_build_context_synchronously
import 'package:auto_route/auto_route.dart';
import 'package:data/finance/repository/wallets_repository.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/views/finances/wallets/ui/widgets/search_transfer_beneficiary_dialog.dart';
import 'package:flutter/material.dart';
import 'package:data/finance/models/wallet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:data/utils/double_ext.dart';

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
  String _selectedRecipientType = 'Beneficiary';
  Wallet? _selectedWallet;

  List<Wallet> _availableWallets = [];

  @override
  void initState() {
    super.initState();
    _fetchAvailableWallets();
  }

  Future<void> _fetchAvailableWallets() async {
    final results = await context.read<WalletsRepository>().fetchWallets();
    results.fold(
      (l) {
        context.snackBarError(l.message);
      },
      (wallets) {
        setState(() {
          _availableWallets = wallets;
        });
      },
    );
  }

  // Check if the selected wallet is from Wealth/Social
  void _checkTransferAvailability() {
    if (widget.wallet.description == 'Wealth' ||
        widget.wallet.description == 'Social') {
      context
          .snackBarError('Wallet transfers are not allowed from this wallet');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                // Show only one "To" field after selection
                DropdownButtonFormField<String>(
                  value: _selectedRecipientType,
                  items: [
                    DropdownMenuItem(
                      value: 'Beneficiary',
                      child: Text('Beneficiary'),
                    ),
                    DropdownMenuItem(
                      value: 'Wallet',
                      child: Text('Wallet'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedRecipientType = value ?? 'Beneficiary';
                      if (_selectedRecipientType == 'Beneficiary') {
                        _selectedWallet = null;
                      }
                    });
                  },
                  decoration:
                      const InputDecoration(labelText: 'Recipient Type'),
                ),
                // Show Beneficiary or Wallet selection based on recipient type
                if (_selectedRecipientType == 'Wallet')
                  EESUpTextFormField(
                    label: 'Select Wallet',
                    readOnly: true,
                    hintText: 'Choose a wallet...',
                    controller: TextEditingController(
                      text: _selectedWallet?.description ?? 'Select a wallet',
                    ),
                    onTap: () {
                      _showWalletSelector(context);
                    },
                  ),
                if (_selectedRecipientType == 'Beneficiary')
                  EESUpTextFormField(
                    label: 'To',
                    readOnly: true,
                    isRequired: true,
                    onTap: () {
                      context
                          .showBottomSheetDialog(
                              child: const SearchTransferBeneficiaryDialog())
                          .then((value) {
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
                    // Check if wallet transfers are allowed
                    if (widget.wallet.description == 'Wealth' ||
                        widget.wallet.description == 'Social') {
                      _checkTransferAvailability();
                      return;
                    }

                    // Validate if the user has selected a beneficiary or wallet
                    if (_selectedRecipientType == 'Beneficiary' &&
                        _beneficiary == null) {
                      context.snackBarError('Please select a beneficiary');
                      return;
                    }

                    if (_selectedRecipientType == 'Wallet' &&
                        _selectedWallet == null) {
                      context.snackBarError('Please select a wallet');
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

                    if (amount == null || amount < 1) {
                      context.snackBarError('Please enter a valid amount');
                      return;
                    }
                    if (amount > widget.wallet.balance) {
                      context.snackBarError('Insufficient funds!!!');
                      return;
                    }
                    final toWalletId = _selectedRecipientType == 'Wallet'
                        ? _selectedWallet!.id
                        : _beneficiary['wallet_id'];

                    if (toWalletId == null) {
                      context.snackBarError('Please select a valid recipient');
                      return;
                    }

                    context.showAlertDialog(
                        'Confirm transfer',
                        'Are you sure you want to transfer R${amount.toRounded()} '
                            'to ${_selectedRecipientType == 'Wallet' ? _selectedWallet!.description : _beneficiary['full_name']}?',
                        onNegative: () {},
                        negativeColor:
                            context.colorScheme.primary.withOpacity(.5),
                        positiveColor: context.colorScheme.primary,
                        positiveText: 'Transfer',
                        negativeText: 'Cancel', onPositive: () async {
                      context.loaderOverlay.show();
                      final results = await context
                          .read<WalletsRepository>()
                          .transferFundsWalletToWallet(
                            fromWalletId: widget.wallet.id,
                            toWalletId: toWalletId,
                            amount: amount,
                            toRef: _beneficiaryRefController.text,
                            fromRef: _myRefController.text,
                          );
                      context.loaderOverlay.hide();

                      results.fold((l) {
                        context.snackBarError(l.message);
                      }, (r) {
                        if (r != null) {
                          context.snackBarSuccess('Transfer successful');
                          Navigator.pop(context);
                        } else {
                          context.snackBarError('Transfer failed');
                        }
                      });
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

  // Method to show wallet selector
  Future<void> _showWalletSelector(BuildContext context) async {
    final selected = await showDialog<Wallet>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Wallet'),
          content: SingleChildScrollView(
            child: Column(
              children: _availableWallets
                  .map((wallet) => ListTile(
                        title: Text(wallet.description),
                        subtitle: Text(
                            'Balance: R${wallet.balance.toRounded()}'),
                        onTap: () {
                          Navigator.pop(context, wallet);
                        },
                      ))
                  .toList(),
            ),
          ),
        );
      },
    );
    if (selected != null) {
      setState(() {
        _selectedWallet = selected;
      });
    }
  }
}




// class _TransferScreenState extends State<TransferScreen> {
//   final _amountController = TextEditingController();
//   final _myRefController = TextEditingController();
//   final _beneficiaryRefController = TextEditingController();
//   dynamic _beneficiary;



//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Scaffold(
//         appBar: AppBar(
//           leading: const BackButton(),
//           centerTitle: true,
//           title: const Text('Transfer'),
//         ),
//         body: Container(
//           decoration: context.bgImage,
//           child: Container(
//             color: Colors.white.withOpacity(.5),
//             child: ListView(
//               padding: const EdgeInsets.only(left: 25, right: 25, bottom: 200),
//               children: [
//                 EESUpTextFormField(
//                   label: 'From',
//                   readOnly: false,
//                   type: TextInputType.number,
//                   controller: TextEditingController(
//                     text:
//                         '${widget.wallet.description} - R${widget.wallet.balance.toRounded()}',
//                   ),
//                 ),
//                 EESUpTextFormField(
//                   label: 'To',
//                   readOnly: true,
//                   isRequired: true,
//                   onTap: () {
//                     context
//                         .showBottomSheetDialog(
//                             child: const SearchTransferBeneficiaryDialog())
//                         .then((value) {
//                       if (value != null) {
//                         _beneficiary = value;
//                         setState(() {});
//                       }
//                     });
//                   },
//                   hintText: 'Search beneficiary..',
//                   controller: TextEditingController(
//                     text: _beneficiary == null
//                         ? null
//                         : '${_beneficiary?['full_name'] ?? '~'} -> ${_beneficiary['description']} wallet',
//                   ),
//                 ),
//                 EESUpTextFormField(
//                   label: 'My Reference',
//                   hintText: 'My reference',
//                   type: TextInputType.text,
//                   controller: _myRefController,
//                   isRequired: true,
//                 ),
//                 EESUpTextFormField(
//                   label: 'Beneficiary Reference',
//                   hintText: 'Beneficiary reference',
//                   type: TextInputType.text,
//                   controller: _beneficiaryRefController,
//                   isRequired: true,
//                 ),
//                 EESUpTextFormField(
//                   label: 'Amount',
//                   hintText: '50.00',
//                   type: TextInputType.number,
//                   controller: _amountController,
//                   isRequired: true,
//                 ),
//                 const SizedBox(height: 15),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_beneficiary == null) {
//                       context.snackBarError('Please select a beneficiary');
//                       return;
//                     }

//                     if (_myRefController.text.isEmpty) {
//                       context.snackBarError('Please enter your reference');
//                       return;
//                     }

//                     if (_beneficiaryRefController.text.isEmpty) {
//                       context
//                           .snackBarError('Please enter beneficiary reference');
//                       return;
//                     }

//                     if (_amountController.text.isEmpty) {
//                       context.snackBarError('Please enter an amount');
//                       return;
//                     }

//                     final amount = double.tryParse(_amountController.text);

//                     if (amount == null) {
//                       context.snackBarError('Please enter a valid amount');
//                       return;
//                     }

//                     if (amount < 1) {
//                       context.snackBarError('Please enter a valid amount');
//                       return;
//                     }

//                     final toWallet = _beneficiary['wallet_id'];

//                     if (toWallet == null) {
//                       context
//                           .snackBarError('Please select a beneficiary wallet');
//                       return;
//                     }

//                     context.showAlertDialog(
//                         'Confirm transfer',
//                         'Are you sure you want to transfer R${amount.toRounded()} '
//                             'to ${_beneficiary['full_name']}?',
//                         onNegative: () {},
//                         negativeColor:
//                             context.colorScheme.primary.withOpacity(.5),
//                         positiveColor: context.colorScheme.primary,
//                         positiveText: 'Transfer',
//                         negativeText: 'Cancel', onPositive: () async {
//                       context.loaderOverlay.show();
//                       final results = await context
//                           .read<WalletsRepository>()
//                           .transferFundsWalletToWallet(
//                             fromWalletId: widget.wallet.id,
//                             toWalletId: toWallet,
//                             amount: amount,
//                             toRef: _beneficiaryRefController.text,
//                             fromRef: _myRefController.text,
//                           );
//                       context.loaderOverlay.hide();

//                       results.fold((l) {
//                         context.snackBarError(l.message);
//                       }, (r) {
//                         if (r != null) {
//                           context.snackBarSuccess('Transfer successful');
//                           Navigator.pop(context);
//                         } else {
//                           context.snackBarError('Transfer failed');
//                         }
//                       });
//                     });
//                   },
//                   child: const Text('Transfer'),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
