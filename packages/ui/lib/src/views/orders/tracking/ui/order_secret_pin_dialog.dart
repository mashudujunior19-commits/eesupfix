import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';

class OrderSecretPinDialog extends StatelessWidget {
  const OrderSecretPinDialog({super.key, required this.pin});
  final String pin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title: const Text('Confirm Order'),
      ),
      body: Container(
        decoration: context.bgImage,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            15.sH,
            Text(
              'By providing this screte pin to an EESUpreneur, you are '
              'confirming that you have reviewed the products and you are '
              'satisfied with the order.',
              textAlign: TextAlign.center,
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: 13.5,
              ),
            ),
            15.sH,
            Text(
              'Screte Pin: $pin',
              textAlign: TextAlign.center,
              style: context.textTheme.labelLarge?.copyWith(
                fontSize: 15,
                color: context.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
