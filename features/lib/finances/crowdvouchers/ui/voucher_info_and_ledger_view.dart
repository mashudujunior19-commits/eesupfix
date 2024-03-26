import 'package:data_sources/finance/models/transaction.dart';
import 'package:data_sources/finance/models/voucher.dart';
import 'package:data_sources/finance/models/voucher_ledger.dart';
import 'package:data_sources/finance/models/voucher_parameter.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';


import 'ledger_transaction_card.dart';
import 'voucher_info_card.dart';

class InfoAndLedgerView extends StatelessWidget {
  const InfoAndLedgerView({
    super.key,
    required this.parameter,
    required this.voucher,
    required this.ledgers,
    required this.transactions,
  });
  final VoucherParameter parameter;
  final Voucher voucher;
  final List<Transaction> transactions;
  final List<VoucherLedger> ledgers;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 500),
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 18, right: 18, top: 15),
          child: Text('Voucher'),
        ).animate().slideIn(50.0),
        VoucherInfoCard(
          voucher: voucher,
          parameter: parameter,
        ).animate().slideIn(50),
        const Padding(
          padding: EdgeInsets.only(left: 18, right: 18, top: 15),
          child: Text('Histroy'),
        ).animate().slideIn(150),
        for (int i = 0; i < ledgers.length; i++) ...[
          LedgerTransactionCard(
            ledger: ledgers[i],
            linkedTransaction: transactions.firstWhere(
              (element) => element.id == ledgers[i].transactionId,
            ),
          ).animate().slideIn((50 * (i + 3)).toDouble()),
        ],
      ],
    );
  }
}
