import 'package:bloc/bloc.dart';
import 'package:data/partners/models/partner.dart';
import 'package:data/partners/models/partner_application.dart';
import 'package:data/partners/models/partner_survey.dart';
import 'package:data/partners/repository/partner_repository.dart';
import 'package:data/surveys/models/survey.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:meta/meta.dart';

part 'application_surveys_event.dart';
part 'application_surveys_state.dart';

class ApplicationSurveysBloc
    extends Bloc<ApplicationSurveysEvent, ApplicationSurveysState> {
  final PartnerRepository _repository;
  ApplicationSurveysBloc(this._repository)
      : super(ApplicationSurveysLoading()) {
    on<ApplicationSurveysFetched>((event, emit) async {
      emit(ApplicationSurveysLoading());
      final ids = event.partner.surveys.map((e) => e.surveyId).toList();
      final results = await _repository.fetchPartnerSurveys(ids);

      List<IndexedSurvey> surveys = [];
      results.fold((l) {
        emit(ApplicationSurveysError(l));
      }, (r) {
        try {
          for (final survey in r) {
            final indexedSurvey = _indexSurvey(event.partner.surveys, survey);
            surveys.add(indexedSurvey);
          }
        } catch (e) {
          emit(
            ApplicationSurveysError(
              EESUpException(
                message: 'Something went wrong while fetching the application',
              ),
            ),
          );
        }
      });
    });

    on<ApplicationUpdated>((event, emit) async {
      emit(ApplicationSurveysLoading());
      final results = await _repository.updatePartnerSurveys(event.application);
      results.fold((l) {
        emit(ApplicationSurveysError(l));
      }, (r) {
        if (r) {
          emit(ApplicationSurveysUpdatedSuccess());
        } else {
          emit(ApplicationSurveysUpdatedFailed());
        }
      });
    });
  }

  IndexedSurvey _indexSurvey(List<PartnerSurvey> pSurveys, Survey survey) {
    try {
      final index = pSurveys.firstWhere((e) => e.surveyId == survey.id).index;
      return (index: index, survey: survey);
    } catch (e) {
      rethrow;
    }
  }
}
