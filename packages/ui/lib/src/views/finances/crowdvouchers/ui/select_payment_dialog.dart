import 'package:data/finance/models/payment_method.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/views/finances/crowdvouchers/ui/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SelectPyamentMethodDialog extends StatelessWidget {
  const SelectPyamentMethodDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: context.height * .5),
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: const Text('Select Payment Method'),
          ),
          body: ListView(
            padding: const EdgeInsets.only(bottom: 200),
            children: [
              PaymentMethodTile(
                amount: 0.00,
                title: 'Credit/Debit Card',
                imagePath: 'assets/images/credit_card.png',
                subtitle: 'Visa, Mastercard, American Express, etc.',
                onTap: (gateway) {
                  Navigator.pop(context, PaymentMethod.instapay);
                },
              ).animate().slideIn(50),
              PaymentMethodTile(
                amount: 0.00,
                title: 'Ozow',
                imagePath: 'assets/images/ozow.png',
                subtitle: 'EFT with Capitec, FNB, ABSA, Nedbank, etc.',
                onTap: (gateway) {
                  Navigator.pop(context, PaymentMethod.ozow);
                },
              ).animate().slideIn(100),
            ],
          ),
        ),
      ),
    );
  }
}
