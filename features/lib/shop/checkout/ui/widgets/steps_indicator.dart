import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class StepIndicator extends StatelessWidget {
  const StepIndicator({super.key, required this.activeStep});
  final int activeStep;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 2),
      width: MediaQuery.sizeOf(context).width,
      color: Colors.white,
      child: EasyStepper(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 30,
          vertical: 0,
        ),
        lineStyle: LineStyle(
          lineLength: 70,
          lineType: LineType.normal,
          finishedLineColor: context.colorScheme.primary,
          activeLineColor: Colors.grey.shade200,
          unreachedLineColor: Colors.grey.shade200,
        ),
        activeStep: activeStep,
        direction: Axis.horizontal,
        stepRadius: 13,
        activeStepBorderColor: context.colorScheme.primary,
        activeStepBorderType: BorderType.normal,
        unreachedStepIconColor: Colors.white,
        unreachedStepBorderColor: Colors.transparent,
        finishedStepBackgroundColor: context.colorScheme.primary,
        unreachedStepBackgroundColor: Colors.grey.shade200,
        showTitle: true,
        steps: [
          EasyStep(
            icon: const Icon(IconlyLight.home),
            customTitle: Text(
              'Address',
              textAlign: TextAlign.center,
              style: context.textTheme.labelSmall,
            ),
          ),
          EasyStep(
            icon: const Icon(BootstrapIcons.shop),
            customTitle: Text(
              'Collection',
              textAlign: TextAlign.center,
              style: context.textTheme.labelSmall,
            ),
          ),
          EasyStep(
            icon: Icon(MdiIcons.currencyUsd),
            customTitle: Text(
              'Payment',
              textAlign: TextAlign.center,
              style: context.textTheme.labelSmall,
            ),
          ),
          EasyStep(
            icon: const Icon(Icons.done),
            customTitle: Text(
              'Summary',
              textAlign: TextAlign.center,
              style: context.textTheme.labelSmall,
            ),
          ),
          EasyStep(
            icon: const Icon(Icons.done_all),
            customTitle: Text(
              'Placed',
              textAlign: TextAlign.center,
              style: context.textTheme.labelSmall,
            ),
          ),
        ],
        onStepReached: (v) {},
      ),
    );
  }
}
