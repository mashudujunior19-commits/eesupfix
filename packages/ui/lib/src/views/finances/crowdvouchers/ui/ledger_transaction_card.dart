import 'package:data/finance/models/transaction.dart';
import 'package:data/finance/models/voucher_ledger.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/utils/date_formatter.dart';
import 'package:ui/src/views/finances/crowdvouchers/ui/linked_transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class LedgerTransactionCard extends StatelessWidget {
  const LedgerTransactionCard({
    super.key,
    required this.ledger,
    required this.linkedTransaction,
  });
  final VoucherLedger ledger;
  final Transaction linkedTransaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 18, right: 18, top: 15),
      width: context.width,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blueGrey.shade50),
        borderRadius: BorderRadius.circular(8),
        image: const DecorationImage(
          fit: BoxFit.fitWidth,
          image: AssetImage(
            'assets/images/wallet_background.png',
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: context.colorScheme.primary.withOpacity(0.1),
                child: Icon(
                  IconlyLight.document,
                  size: 30,
                  color: Colors.grey.shade500,
                ),
              ),
              10.sW,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Opening Balance: R${ledger.openingBalance?.toStringAsFixed(2) ?? '~'}',
                    style: context.textTheme.labelSmall,
                  ),
                  Container(
                    width: context.width * 0.65,
                    height: .4,
                    color: Colors.grey.shade500,
                    margin: const EdgeInsets.only(top: 4, bottom: 4),
                  ),
                  Text(
                    'Profit Share: R${ledger.profitShare?.toStringAsFixed(2) ?? '~'}',
                    style: context.textTheme.labelSmall,
                  ),
                  Container(
                    width: context.width * 0.6,
                    height: .4,
                    color: Colors.grey.shade500,
                    margin: const EdgeInsets.only(top: 4, bottom: 4),
                  ),
                  Text(
                    'Closing Balance: R${ledger.closingBalance.toStringAsFixed(2)}',
                    style: context.textTheme.labelSmall,
                  ),
                  Container(
                    width: context.width * 0.55,
                    height: .4,
                    color: Colors.grey.shade500,
                    margin: const EdgeInsets.only(top: 4, bottom: 4),
                  ),
                  Text(
                    DateFormatter.formatDateToNameday(ledger.createdAt),
                    style: context.textTheme.labelSmall,
                  ),
                ],
              ),
            ],
          ),
          10.sH,
          const Text('Transaction'),
          10.sH,
          LinkedTransactionCard(transaction: linkedTransaction)
        ],
      ),
    );
  }
}
