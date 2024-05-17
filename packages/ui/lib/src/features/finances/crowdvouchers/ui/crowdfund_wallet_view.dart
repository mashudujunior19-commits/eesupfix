import 'package:data/finance/models/transaction.dart';
import 'package:data/finance/models/wallet.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/features/finances/wallets/ui/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CrowdfundWalletView extends StatelessWidget {
  const CrowdfundWalletView({super.key, required this.wallet});
  final Wallet wallet;

  @override
  Widget build(BuildContext context) {
    final List<Transaction> transactions = [];
    return Container(
      decoration: context.bgImage,
      child: ListView(
        children: [
          for (int i = 0; i < transactions.length; i++)
            TransactionCard(transaction: transactions[i])
                .animate()
                .slideIn(i * 50),
          300.sH,
        ],
      ),
    );
  }
}
