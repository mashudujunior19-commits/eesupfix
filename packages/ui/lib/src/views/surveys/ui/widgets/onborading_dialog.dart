import 'package:data/surveys/models/survey.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class SurveyOnbordingDialog extends StatelessWidget {
  const SurveyOnbordingDialog({super.key, required this.survey});
  final Survey survey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    //final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * .3),
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            actions: [
              TextButton(
                onPressed: () {
                  // setSurvey(ref, survey);
                  // Navigator.pop(context, true);
                },
                child: Row(
                  children: [
                    Text(
                      'Take ${survey.type.name}',
                      style: const TextStyle(fontSize: 15.5),
                    ),
                    const SizedBox(width: 7),
                    const Icon(IconlyLight.play)
                  ],
                ),
              ),
              const SizedBox(width: 15),
            ],
          ),
          body: Center(
            child: ListView(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 100),
              children: [
                const SizedBox(height: 30),
                Text(
                  survey.title,
                  style: textTheme.bodyMedium?.copyWith(fontSize: 18),
                  textAlign: TextAlign.start,
                ),
                if (survey.imageUrl != null)
                  Container(
                    margin: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 15,
                      bottom: 15,
                    ),
                    height: 300,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(survey.imageUrl ?? ''),
                    ),
                  ),
                if (survey.description != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      survey.description ?? '',
                      style: textTheme.bodySmall?.copyWith(fontSize: 15),
                      textAlign: TextAlign.start,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
