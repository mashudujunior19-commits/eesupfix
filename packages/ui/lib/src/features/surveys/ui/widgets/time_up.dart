import 'package:flutter/material.dart';

class TimeUp extends StatelessWidget {
  const TimeUp({super.key});

  @override
  Widget build(BuildContext context) {
    // final survey = currentSurvey(ref);
    // if (survey == null) {
    //   return const SizedBox.shrink();
    // }
    return Container(
      margin: const EdgeInsets.only(top: 15, bottom: 15),
      padding: const EdgeInsets.all(25),
      child: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Text(
              '🕘 Time up!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Text('You have reached the time limit for this ${survey.type.name}',
            //     textAlign: TextAlign.center),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
