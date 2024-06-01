import 'package:bloc/bloc.dart';
import 'package:data/notifications/repository/survey_repository.dart';
import 'package:data/surveys/models/survey.dart';
import 'package:meta/meta.dart';
import 'package:data/utils/eesup_exception.dart';

part 'surveys_list_event.dart';
part 'surveys_list_state.dart';

class SurveysListBloc extends Bloc<SurveysListEvent, SurveysListState> {
  final SurveyRepository _repository;
  SurveysListBloc(this._repository) : super(SurveysListLoading()) {
    on<SurveysListFetched>((event, emit) async {
      emit(SurveysListLoading());
      late final List<Survey> surveys;
      late final List<Survey> tests;
      final sResults = await _repository.fetchSurveys(SurveyType.Survey);
      sResults.fold((left) {
        emit(SurveysListError(left));
      }, (right) {
        surveys = right;
      });
      final tResults = await _repository.fetchSurveys(SurveyType.Test);
      tResults.fold((left) {
        emit(SurveysListError(left));
      }, (right) {
        tests = right;
      });
      emit(SurveysListLoaded(surveys, tests));
    });
  }
}
