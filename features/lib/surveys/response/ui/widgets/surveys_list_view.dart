import 'package:data_sources/surveys/models/survey.dart';
import 'package:features/surveys/listing/ui/survey_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// final surveysProvider = FutureProvider.family
//     .autoDispose<List<Survey>, SurveyType>((ref, type) async {
//   final repo = ref.read(surveyRepoProvider);
//   final result = await repo.fetchSurveys(type);
//   return result.fold(
//     (l) {
//       throw l;
//     },
//     (r) => r,
//   );
// });

class SurveyListView extends StatelessWidget {
  const SurveyListView({super.key, required this.type});
  final SurveyType type;

  @override
  Widget build(BuildContext context) {
    // final asyncSurveys = ref.watch(surveysProvider(type));

    final surveys = <Survey>[];

    return ListView.builder(
      padding: const EdgeInsets.only(left: 5, right: 5),
      itemCount: surveys.length,
      itemBuilder: (context, index) {
        final survey = surveys[index];
        return SurveyCard(survey: survey)
            .animate()
            .fadeIn(delay: (200 + index * 50).ms)
            .slide(
              delay: (100 * index).ms,
              begin: const Offset(0, 1),
              end: const Offset(0, 0),
              duration: 600.ms,
              curve: Curves.easeInOutCubic,
            );
      },
    );
  }
}
