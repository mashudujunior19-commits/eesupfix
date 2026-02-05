import 'package:auto_route/auto_route.dart';
import 'package:ui/src/core/env/environment.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/extensions/context_environment_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_ozow/flutter_ozow.dart';
import 'package:data/utils/eesup_exception.dart';

typedef OzowPayment = ({
  int reference,
  double amount,
  String bankRef,
  String type,
});

@RoutePage()
class OzowScreen extends StatefulWidget {
  const OzowScreen({
    super.key,
    required this.reference,
    required this.amount,
    required this.type,
    required this.bankRef,
  });
  final int reference;
  final double amount;
  final String bankRef;
  final String type;

  @override
  State<OzowScreen> createState() => _OzowScreenState();
}

class _OzowScreenState extends State<OzowScreen> {
  OzowStatus? status;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: status == null
              ? BackButton(
                  onPressed: () {
                    Navigator.pop(context, status == OzowStatus.complete);
                  },
                )
              : null,
          title: const Text('Ozow Payment'),
        ),
        body: () {
          final privateKey = dotenv.env['OZOW_PRIVATE_KEY'];
          final apitKey = dotenv.env['OZOW_API_KEY'];
          final siteCode = dotenv.env['OZOW_SITE_CODE'];
          final eesupKey = dotenv.env['EESUP_API_KEY'];
          final eesupApiUrl = dotenv.env['EESUP_API_BASE_URL'];
          // const eesupApiUrl = 'https://zngp5d89-8080.inc1.devtunnels.ms/v1';
          if (privateKey == null ||
              apitKey == null ||
              siteCode == null ||
              eesupKey == null ||
              eesupApiUrl == null) {
            return FullScreenError(
              exception: EESUpException(
                message: 'There was an internal'
                    ' error while initiating your payment',
              ),
            );
          }

          return FlutterOzow(
            transactionId: widget.reference,
            privateKey: privateKey,
            apiKey: apitKey,
            siteCode: siteCode,
            bankRef: widget.bankRef,
            amount: widget.amount,
            isTest: context.environment.type == Environment.development,
            optional2: eesupKey,
            optional3: widget.type,
            notifyUrl: '$eesupApiUrl/payments/ozow/notify',
            onComplete: (transaction, status) {
              setState(() {
                this.status = status;
              });
            },
            onError: (e, m) {},
          );
        }(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: status != null
            ? Container(
                margin: EdgeInsets.only(
                  left: 35,
                  right: 35,
                  bottom: MediaQuery.sizeOf(context).height * 0.35,
                ),
                height: 45,
                child: Builder(builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, status == OzowStatus.complete);
                    },
                    child: const Text('Finish'),
                  );
                }),
              ).animate().slideIn(0)
            : null,
      ),
    );
  }
}
