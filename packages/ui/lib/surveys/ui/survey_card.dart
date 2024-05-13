import 'package:data/surveys/models/survey.dart';
import 'package:ui/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

///Displays a survey card in a list of surveys.
class SurveyCard extends StatelessWidget {
  const SurveyCard({
    super.key,
    required this.survey,
    this.margin,
    this.onDone,
    this.showResults = false,
  });

  final Survey survey;
  final EdgeInsets? margin;
  final bool showResults;
  final void Function(String?)? onDone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        // final pre = survey.preSurvey;
        // if (pre != null) {
        //   if (pre.respondedAt == null) {
        //     showSnackBar(
        //       context: context,
        //       message: 'Complete the ${pre.title} ${pre.type.name} first.',
        //     );
        //     return;
        //   }
        // }

        // if ((survey.imageUrl != null) || (survey.description != null)) {
        //   showSurveyOnbordingDialog(context, survey).then((value) {
        //     setSurvey(ref, survey);
        //     if (value == true) {
        //       context.push(ResponseScreen.route).then((results) {
        //         if (onDone != null) {
        //           final id = results as String?;
        //           onDone?.call(id);
        //         } else {
        //           ref.invalidate(surveysProvider);
        //         }
        //       });
        //     }
        //   });
        // } else {
        //   setSurvey(ref, survey);
        //   context.push(ResponseScreen.route).then((results) {
        //     if (onDone != null) {
        //       final id = results as String?;
        //       onDone?.call(id);
        //     } else {
        //       ref.invalidate(surveysProvider);
        //     }
        //   });
        // }
      },
      child: Container(
        margin: margin ?? const EdgeInsets.only(right: 15, left: 15, top: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.shade300,
            width: .5,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 5, right: 10),
          leading: CircleAvatar(
            backgroundColor: Colors.green.shade50.withOpacity(.7),
            child: const Icon(IconlyLight.chart, color: Colors.green),
          ),
          title: Text(survey.title, style: textTheme.labelMedium),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '⏱ ${survey.duration.toString()} minutes',
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.primary,
                  fontSize: 13,
                ),
              ),
              2.sH,
              if (showResults &&
                  survey.respondedAt != null &&
                  survey.enableScoring == true)
                Text(
                  survey.passed == true ? '📊 Passed' : 'Did not pass',
                  style: textTheme.labelSmall,
                ),
            ],
          ),
          trailing: const Icon(IconlyLight.play),
        ),
      ),
    );
  }
}
