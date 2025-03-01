import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:data/finance/models/transaction.dart';
import 'package:data/utils/double_ext.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.transaction});
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
        padding: const EdgeInsets.only(bottom: 5, left: 3, right: 5, top: 3),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          border: Border(
            left: BorderSide(
              color: transaction.vested ? colorScheme.primary : Colors.red,
              width: 2,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blueGrey.shade50,
                  child: const Icon(
                    BootstrapIcons.receipt,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    5.sH,
                    SizedBox(
                      width: context.width * .4,
                      child: Text(
                        transaction.description,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.labelMedium?.copyWith(fontSize: 13),
                        maxLines: 2,
                      ),
                    ),
                    Text(
                      '${DateFormatter.formatTime(transaction.createdAt.add(const Duration(hours: 2)))} ${DateFormatter.yetAnotherDateFormat(transaction.createdAt)}',
                      style: textTheme.labelSmall,
                    ),
                    5.sH,
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                transaction.value < 0
                    ? '- R${transaction.value.toRounded().substring(1)}'
                    : 'R${transaction.value.toRounded()}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
