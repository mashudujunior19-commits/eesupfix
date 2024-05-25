import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/features/shop/checkout/bloc/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

class ResultStep extends StatelessWidget {
  const ResultStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        if (state is CheckoutCompleted) {
          if (!state.isSuccess) {
            return _failed(context);
          }
          return _success(context);
        } else {
          return _failed(context);
        }
      },
    );
  }

  Column _failed(BuildContext context) {
    return Column(
      children: [
        150.sH,
        const SizedBox(
          height: 100,
          child: RiveAnimation.asset(
            'assets/animations/error.riv',
          ),
        ),
        15.sH,
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Finish',
            style: TextStyle(
              color: Colors.redAccent,
            ),
          ),
        )
      ],
    );
  }

  Column _success(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        150.sH,
        const SizedBox(
          height: 100,
          child: RiveAnimation.asset(
            'assets/animations/success.riv',
          ),
        ),
        15.sH,
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('Finish'),
        )
      ],
    );
  }
}
