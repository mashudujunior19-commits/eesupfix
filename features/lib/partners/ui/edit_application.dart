import 'package:data_sources/surveys/models/survey.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/surveys/ui/survey_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:data_sources/partners/models/partner_application.dart';
import 'package:data_sources/partners/models/partner.dart';

typedef EditApplcationExtra = ({PartnerApplication app, Partner partner});
typedef SurveyRecordSort = ({int index, Survey survey});

// final _surveysProvider =
//     FutureProvider.family<List<SurveyRecordSort>, EditApplcationExtra>(
//         (ref, extra) async {
//   final repo = ref.watch(partnerRepoProvider);
//   final results = await repo.fetchPartnerSurveys(
//     extra.partner.surveys.map((e) => e.surveyId).toList(),
//   );
//   return results.fold(
//     (l) => throw l,
//     (surveys) {
//       final List<SurveyRecordSort> records = [];
//       for (final survey in surveys) {
//         final index = extra.partner.surveys
//             .firstWhere((e) => e.surveyId == survey.id)
//             .index;
//         records.add(
//           (index: index, survey: survey),
//         );
//       }
//       records.sort((a, b) => a.index.compareTo(b.index));
//       return records;
//     },
//   );
// });

class EditApplication extends StatelessWidget {
  const EditApplication({super.key, required this.extra});
  static const String route = '/edit-application';
  final EditApplcationExtra extra;

  @override
  Widget build(BuildContext context) {
    final app = extra.app;
    final partner = extra.partner;
    final surveys = <Survey>[];
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text('REF-${app.id} ${partner.title}'),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            24.sW,
            Icon(
              IconlyBroken.arrowDown,
              color: context.colorScheme.primary.withOpacity(.5),
              size: 20,
            ),
          ],
        ).animate().slideIn(index * 50),
        itemCount: surveys.length,
        itemBuilder: (context, index) {
          return 0.sW;
          // final survey = surveys[index];
          // return _SurveyCard(
          //   survey: survey,
          //   extra: extra,
          // ).animate().slideIn(index * 50);
        },
      ),
    ));
  }
}

class _SurveyCard extends StatelessWidget {
  const _SurveyCard({required this.survey, required this.extra});

  final SurveyRecordSort survey;
  final EditApplcationExtra extra;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 17, right: 20),
      leading: CircleAvatar(
        backgroundColor: context.colorScheme.primary.withOpacity(.1),
        child: Text(
          survey.index.toString(),
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colorScheme.primary,
          ),
        ),
      ),
      title: SurveyCard(
        survey: survey.survey,
        margin: const EdgeInsets.all(0),
        showResults: true,
        onDone: (id) async {
          // if (id != null) {
          //   final currentResponses = [...extra.app.surveyResponses];

          //   ///check if the survey is already in the list
          //   final index = currentResponses
          //       .indexWhere((e) => e.surveyId == survey.survey.id);

          //   if (index != -1) {
          //     currentResponses[index] = currentResponses[index].copyWith(
          //       index: survey.index,
          //       surveyId: survey.survey.id,
          //       responseId: id,
          //     );
          //   } else {
          //     currentResponses.add(
          //       PartnerSurveyResponse(
          //         index: survey.index,
          //         surveyId: survey.survey.id,
          //         responseId: id,
          //       ),
          //     );
          //   }

          //   context.loaderOverlay.show();
          //   final results =
          //       await ref.read(partnerRepoProvider).updatePartnerSurveys(
          //             extra.app.copyWith(surveyResponses: currentResponses),
          //           );
          //   context.loaderOverlay.hide();

          //   results.fold((l) {
          //     context.snackBarError(l.message);
          //   }, (r) {
          //     if (r) {
          //       context.snackBarSuccess('Response captured.');
          //     } else {
          //       context.snackBarError(
          //         'There was an error while capturing response.',
          //       );
          //     }
          //   });
          // }
          // ref.invalidate(_surveysProvider(extra));
        },
      ),
    );
  }
}
