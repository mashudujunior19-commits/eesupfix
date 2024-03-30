import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/finances/crowdvouchers/ui/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PaymentMethodStep extends StatelessWidget {
  const PaymentMethodStep({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PaymentMethodTile(
          title: 'Credit/Debit Card',
          imagePath: 'assets/images/credit_card.png',
          subtitle: 'Visa, Mastercard, American Express, EFT.',
          onTap: () {
            tabController.animateTo(tabController.index + 1);
          },
        ).animate().slideIn(0),
        PaymentMethodTile(
          title: 'Ozow',
          imagePath: 'assets/images/ozow.png',
          subtitle: 'EFT with Capitec, FNB, ABSA, Nedbank, etc.',
          onTap: () {},
        ).animate().slideIn(50),
        PaymentMethodTile(
          title: 'Retail wallet',
          imagePath: 'assets/images/wallet.png',
          subtitle: 'Available balance:',
          onTap: () {},
        ).animate().slideIn(100),
        PaymentMethodTile(
          title: 'Split payment',
          imagePath: 'assets/images/bill.png',
          subtitle: 'Use your retail wallet balance and pay'
              ' the remaining amount with your Credit/Debit Card or Ozow.',
          onTap: () {},
        ).animate().slideIn(150),
      ],
    );
  }
}
