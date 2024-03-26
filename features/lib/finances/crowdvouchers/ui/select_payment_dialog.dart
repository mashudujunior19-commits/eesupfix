import 'package:data_sources/finance/models/payment_method.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/finances/crowdvouchers/ui/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

Future<Object?> selectPaymentMethodIDialog(BuildContext context) {
  return showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return const _SelectPyamentMethodDialog(
          key: Key('select_payment_method_dialog'));
    },
    animationType: DialogTransitionType.slideFromBottomFade,
    curve: Curves.easeIn,
    duration: 400.ms,
  );
}

class _SelectPyamentMethodDialog extends StatelessWidget {
  const _SelectPyamentMethodDialog({super.key});

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
                title: 'Credit/Debit Card',
                imagePath: 'assets/images/credit_card.png',
                subtitle: 'Visa, Mastercard, American Express, etc.',
                onTap: () {
                  Navigator.pop(context, PaymentMethod.instapay);
                },
              ).animate().slideIn(50),
              PaymentMethodTile(
                title: 'Ozow',
                imagePath: 'assets/images/ozow.png',
                subtitle: 'EFT with Capitec, FNB, ABSA, Nedbank, etc.',
                onTap: () {
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
