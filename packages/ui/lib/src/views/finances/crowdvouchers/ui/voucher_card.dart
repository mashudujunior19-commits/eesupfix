import 'package:data/finance/models/voucher.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';
import 'package:data/utils/double_ext.dart';

class VoucherCard extends StatelessWidget {
  const VoucherCard({super.key, required this.voucher});
  final Voucher voucher;

  @override
  Widget build(BuildContext context) {
    if (voucher.confirmedAt == null) return 0.sH;
    return GestureDetector(
      onTap: () {
        // context
        //     .push(VoucherViewScreen.route, extra: voucher.id)
        //     .whenComplete(() => null);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
        decoration: BoxDecoration(
          image: const DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage(
              'assets/images/wallet_background.png',
            ),
          ),
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: Colors.blueGrey.shade50,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.only(
            left: 10,
            top: 3,
            bottom: 3,
            right: 10,
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.green.shade50.withOpacity(.5),
            child: Image.asset(
              'assets/images/profit.png',
              width: 25,
              color: context.colorScheme.primary,
            ),
          ),
          title: Text(
            voucher.id.toString(),
            style: context.textTheme.labelMedium,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Period: ${voucher.period} Months',
                style: context.textTheme.labelSmall,
              ),
              Text(
                voucher.cycle.toString(),
                style: context.textTheme.labelSmall,
              ),
            ],
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Balance',
                style: context.textTheme.labelSmall,
              ),
              5.sH,
              Text(
                'R${voucher.balance.toRounded()}',
                style: context.textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
