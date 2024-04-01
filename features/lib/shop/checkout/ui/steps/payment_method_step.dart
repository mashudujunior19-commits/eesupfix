import 'package:data_sources/finance/models/payment_method.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/finances/crowdvouchers/ui/payment_method.dart';
import 'package:features/shop/checkout/bloc/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            context.read<CheckoutBloc>().add(
                  PaymentMethodUpdated(PaymentMethod.instapay),
                );
            tabController.animateTo(tabController.index + 1);
          },
        ).animate().slideIn(0),
        PaymentMethodTile(
          title: 'Ozow',
          imagePath: 'assets/images/ozow.png',
          subtitle: 'EFT with Capitec, FNB, ABSA, Nedbank, etc.',
          onTap: () {
            context.read<CheckoutBloc>().add(
                  PaymentMethodUpdated(PaymentMethod.ozow),
                );
            tabController.animateTo(tabController.index + 1);
          },
        ).animate().slideIn(50),
        PaymentMethodTile(
          title: 'Retail wallet',
          imagePath: 'assets/images/wallet.png',
          subtitle: 'Available balance:',
          onTap: () {
            context.read<CheckoutBloc>().add(
                  PaymentMethodUpdated(PaymentMethod.retailWallet),
                );
            tabController.animateTo(tabController.index + 1);
          },
        ).animate().slideIn(100),
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
          child: Row(
            children: [
              Expanded(child: Divider(color: Colors.grey.shade300)),
              10.sW,
              const Text('Or'),
              10.sW,
              Expanded(child: Divider(color: Colors.grey.shade300)),
            ],
          ),
        ).animate().slideIn(150),
        PaymentMethodTile(
          title: 'Split payment with Instapay',
          imagePath: 'assets/images/bill.png',
          subtitle: 'Use your retail wallet balance and pay'
              ' the remaining amount with your Credit/Debit Card or Ozow.',
          onTap: () {
            context.read<CheckoutBloc>().add(
                  PaymentMethodUpdated(
                      PaymentMethod.splitInstapayRetailWalletPayment),
                );
            tabController.animateTo(tabController.index + 1);
          },
        ).animate().slideIn(200),
        PaymentMethodTile(
          title: 'Split payment with Ozow',
          imagePath: 'assets/images/bill.png',
          subtitle: 'Use your retail wallet balance and pay'
              ' the remaining amount with your Credit/Debit Card or Ozow.',
          onTap: () {
            context.read<CheckoutBloc>().add(
                  PaymentMethodUpdated(
                      PaymentMethod.splitOzowRetailWalletPayment),
                );
            tabController.animateTo(tabController.index + 1);
          },
        ).animate().slideIn(250),
      ],
    );
  }
}
