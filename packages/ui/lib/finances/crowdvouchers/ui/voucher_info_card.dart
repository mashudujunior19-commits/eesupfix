import 'package:data/finance/models/voucher.dart';
import 'package:data/finance/models/voucher_parameter.dart';
import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:ui/core/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';

class VoucherInfoCard extends StatelessWidget {
  const VoucherInfoCard({
    super.key,
    required this.voucher,
    required this.parameter,
  });
  final Voucher voucher;
  final VoucherParameter parameter;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 18, right: 18, top: 15),
      width: context.width,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
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
          ExpandedTile(
            theme: const ExpandedTileThemeData(
              headerColor: Colors.transparent,
              headerRadius: 0,
              headerPadding: EdgeInsets.only(left: 5, right: 5),
              headerSplashColor: Colors.transparent,
              contentBackgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 10,
                bottom: 10,
              ),
              contentRadius: 0,
            ),
            controller: ExpandedTileController(isExpanded: false),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Balance',
                      style: context.textTheme.labelSmall,
                    ),
                    Text(
                      'R${voucher.balance.toStringAsFixed(2)}',
                      style: context.textTheme.labelSmall,
                    ),
                  ],
                ),
                Container(
                  width: context.width,
                  height: .3,
                  color: Colors.grey.shade500,
                  margin: const EdgeInsets.only(top: 4, bottom: 4),
                ),
              ],
            ),
            trailing: Icon(
              IconlyLight.arrowRight2,
              color: Colors.grey.shade500,
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Value',
                      style: context.textTheme.labelSmall,
                    ),
                    Text(
                      'R${voucher.value.toStringAsFixed(2)}',
                      style: context.textTheme.labelSmall,
                    ),
                  ],
                ),
                Container(
                  width: context.width,
                  height: .3,
                  color: Colors.grey.shade500,
                  margin: const EdgeInsets.only(top: 4, bottom: 4),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cycle',
                      style: context.textTheme.labelSmall,
                    ),
                    Text(
                      voucher.cycle.toString(),
                      style: context.textTheme.labelSmall,
                    ),
                  ],
                ),
                Container(
                  width: context.width,
                  height: .3,
                  color: Colors.grey.shade500,
                  margin: const EdgeInsets.only(top: 4, bottom: 4),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Period',
                      style: context.textTheme.labelSmall,
                    ),
                    Text(
                      '${voucher.period} Months',
                      style: context.textTheme.labelSmall,
                    ),
                  ],
                ),
                Container(
                  width: context.width,
                  height: .3,
                  color: Colors.grey.shade500,
                  margin: const EdgeInsets.only(top: 4, bottom: 4),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profit Share',
                      style: context.textTheme.labelSmall,
                    ),
                    Text(
                      '${parameter.interest.toStringAsFixed(2)}%',
                      style: context.textTheme.labelSmall,
                    ),
                  ],
                ),
                Container(
                  width: context.width,
                  height: .3,
                  color: Colors.grey.shade500,
                  margin: const EdgeInsets.only(top: 4, bottom: 4),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'End Date',
                      style: context.textTheme.labelSmall,
                    ),
                    Text(
                      DateFormatter.formatDateToNameday(voucher.endDate),
                      style: context.textTheme.labelSmall,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
