import 'package:auto_route/auto_route.dart';
import 'package:features/core/extensions/bg_image_deco_ext.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/finances/wallets/ui/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:data_sources/finance/models/wallet.dart';
import 'package:data_sources/finance/models/transaction.dart';
// final transactionsProvider =
//     FutureProvider.family.autoDispose<List<Transaction>, int>((ref, id) async {
//   final repo = ref.read(walletRepoProvider);
//   final trans = await repo.fetchWalletTransactions(id);

//   return trans.fold((l) {
//     throw l;
//   }, (r) => r);
// });


@RoutePage()
class WalletViewScreen extends StatelessWidget {
  const WalletViewScreen({super.key, required this.wallet});
  static const route = '/wallet-view';
  final Wallet wallet;

  @override
  Widget build(BuildContext context) {
    final List<Transaction> transactions = [];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${wallet.description} Wallet'),
        ),
        body: Container(
          decoration: context.bgImage,
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 15, bottom: 15),
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your balance",
                          style: context.textTheme.labelMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          wallet.balance < 0
                              ? '- R${wallet.balance.toStringAsFixed(2).substring(1)}'
                              : 'R${wallet.balance.toStringAsFixed(2)}',
                          style: context.textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                    if (wallet.transfers == true)
                      TextButton(
                        onPressed: () {
                          // context
                          //     .push(TransferScreen.route, extra: wallet)
                          //     .whenComplete(() {
                          //   ref.invalidate(transactionsProvider(wallet.id));
                          // });
                        },
                        child: const Text("Transfer"),
                      )
                  ],
                ),
              ).animate().slideIn(0),
              for (int i = 0; i < transactions.length; i++)
                TransactionCard(transaction: transactions[i])
                    .animate()
                    .slideIn(i * 50),
              300.sH,
            ],
          ),
        ),
      ),
    );
  }
}
