import 'package:flutter/material.dart';

class SurveyTimer extends StatelessWidget {
  const SurveyTimer({super.key});

  @override
  Widget build(BuildContext context) {
    // if (survey?.enforceTimeLimit == true && survey?.duration != null) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(top: 15, bottom: 15),
        //   child: Text(
        //     '🕘 Time left: ${timer(ref).inMinutes} minutes ${timer(ref).inSeconds.remainder(60)} seconds',
        //     textAlign: TextAlign.center,
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 27, right: 27),
        //   child: ClipRRect(
        //     borderRadius: BorderRadius.circular(5),
        //     child: LinearProgressIndicator(
        //       minHeight: 8,
        //       valueColor: (timer(ref).inMinutes) / (survey!.duration!) < .1
        //           ? const AlwaysStoppedAnimation<Color>(Colors.redAccent)
        //           : AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
        //       value: (timer(ref).inMinutes) / (survey.duration!),
        //     ),
        //   ),
        // ),
      ],
    );
    // } else {
    //   return const SizedBox.shrink();
    // }
  }
}
