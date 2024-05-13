import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/finance/models/transaction.dart';
import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:ui/core/extensions/sizedbox_ext.dart';
import 'package:ui/core/utils/date_formatter.dart';
import 'package:flutter/material.dart';

class LinkedTransactionCard extends StatelessWidget {
  const LinkedTransactionCard({super.key, required this.transaction});
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.only(bottom: 5, left: 3, right: 10, top: 3),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade50.withOpacity(0.4),
          border: Border(
            left: BorderSide(
              color: transaction.vested ? colorScheme.primary : Colors.red,
              width: 2.4,
            ),
            bottom: BorderSide(
              color: Colors.grey.shade300,
              width: 0.6,
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
                  radius: 23,
                  backgroundColor: context.colorScheme.primary.withOpacity(0.1),
                  child: const Icon(
                    BootstrapIcons.receipt,
                    color: Colors.grey,
                  ),
                ),
                10.sW,
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
                        style: textTheme.labelMedium?.copyWith(fontSize: 11.5),
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
                    ? '- R${transaction.value.toStringAsFixed(2).substring(1)}'
                    : 'R${transaction.value.toStringAsFixed(2)}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
