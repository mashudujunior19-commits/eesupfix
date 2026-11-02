import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/views/shop/checkout/bloc/checkout_bloc.dart';
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

  Widget _success(BuildContext context) => const _SuccessView();
}

/// Shows the success animation briefly, then takes the user back to the main
/// screen on its own, so they never have to tap "Finish".
class _SuccessView extends StatefulWidget {
  const _SuccessView();

  @override
  State<_SuccessView> createState() => _SuccessViewState();
}

class _SuccessViewState extends State<_SuccessView> {
  static const _delay = Duration(milliseconds: 1800);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(_delay, _goHome);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _goHome() {
    if (!mounted) return;
    // The cart was cleared when the order was placed; go back to the main page.
    context.router.pushAll([const OverviewRoute()]);
  }

  @override
  Widget build(BuildContext context) {
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
            _timer?.cancel();
            _goHome();
          },
          child: const Text('Finish'),
        )
      ],
    );
  }
}
