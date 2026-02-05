import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_yoco/flutter_yoco.dart';

@RoutePage()
class YocoPaymentScreen extends StatelessWidget {
  const YocoPaymentScreen({
    super.key,
    required this.reference,
    required this.amount,
  });
  final int reference;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ),
        body: () {
          final secretKey = dotenv.env['YOCO_SECRET_KEY'];

          return FlutterYoco(
            secretKey: secretKey!,
            amount: 100,
            transactionId: 'id',
            successUrl: 'https://eesup.com/success/',
            cancelUrl: 'https://eesup.com/failed/',
            failureUrl: 'https://eesup.com/canceled/',
            onComplete: (transaction) {},
          );
        }(),
      ),
    );
  }
}
