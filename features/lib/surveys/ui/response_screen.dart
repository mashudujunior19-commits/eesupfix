import 'package:auto_route/auto_route.dart';
import 'package:features/core/extensions/context_alerts_ext.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:flutter/material.dart';


///Displays the current question in a survey.
///as well as the navigation and submit buttons.
@RoutePage()
class ResponseScreen extends StatelessWidget {
  const ResponseScreen({super.key});
  static const route = '/take-survey';

  @override
  Widget build(BuildContext context) {
    // final question = currentQuestion(ref);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              context.showAlertDialog(
                'Do you want to exit?',
                'Are you sure you want to exit? Your progress will be Lost.',
                positiveColor: context.colorScheme.error,
                negativeColor: context.colorScheme.primary,
                negativeText: 'No, Continue',
                positiveText: 'Yes, Exit',
                onNegative: () {},
                onPositive: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              );

              /// _exitConfirmationDialog(context);
            },
          ),
          // title: Text(
          //   'Question ${(index(ref) + 1).toString()}/${(maxIndex(ref) + 1).toString()}',
          // ),
        ),
        // body: question != null
        //     ? CurrentQuestionView(question: question)
        //     : FullScreenError(
        //         error: EESUpException(message: 'No question found.'),
        //       ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: timeIsUp(ref) || index(ref) == maxIndex(ref)
        //     ? const ResponseSubmitButton()
        //     : const ResponseNavButton(),
      ),
    );
  }
}
