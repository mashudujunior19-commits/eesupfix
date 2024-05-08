import 'package:features/core/extensions/context_alerts_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';



class ConfirmOrderCollectionDialog extends StatelessWidget {
  ConfirmOrderCollectionDialog({super.key, required this.pin, this.isEESUpoolOrder = false});
  final String pin;
  final bool isEESUpoolOrder;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Confirm Collection'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            isEESUpoolOrder
                ? 'Use the 5 digits pin that is provided by the Delivery team to confirm the collection of the order'
                : 'The Customer has to provide the 5 Digits Pin to confirm the collection of the order',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 14,
                ),
            textAlign: TextAlign.center,
          ),
          10.sH,
          EESUpTextFormField(
            hintText: 'Pin here',
            controller: controller,
            type: TextInputType.number,
          ),
          20.sH,
          ElevatedButton(
            onPressed: () {
              if (controller.text == pin) {
                Navigator.pop(context, true);
              } else {
                context.snackBarError('Invalid Pin');
              }
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
