import 'package:bloc/bloc.dart';
import 'package:data/surveys/models/choice.dart';
import 'package:data/surveys/models/question.dart';
import 'package:data/surveys/models/survey.dart';
import 'package:meta/meta.dart';

part 'survey_response_event.dart';
part 'survey_response_state.dart';

class SurveyResponseBloc
    extends Bloc<SurveyResponseEvent, SurveyResponseState> {
  SurveyResponseBloc() : super(SurveyResponseInitial()) {
    on<ResponseInitialized>((event, emit) {
      emit(CurrentResponseSurvey(event.survey, 0));
    });

    on<NextQuestionPressed>((event, emit) {
      if (state is CurrentResponseSurvey) {
        emit(
          CurrentResponseSurvey(
            (state as CurrentResponseSurvey).survey,
            event.next,
          ),
        );
      }
    });

    on<PrevQuestionPressed>((event, emit) {
      if (state is CurrentResponseSurvey) {
        emit(
          CurrentResponseSurvey(
            (state as CurrentResponseSurvey).survey,
            event.next,
          ),
        );
      }
    });

    on<QuestionResponseUpdated>((event, emit) {
      if (state is CurrentResponseSurvey) {
        final current = (state as CurrentResponseSurvey);
        var questions = [...current.survey.questions];
        questions[current.index] = event.question;
        emit(
          CurrentResponseSurvey(
            current.survey.copyWith(questions: questions),
            current.index,
          ),
        );
      }
    });

    on<MultiChoiceResponseUpdated>((event, emit) {
      if (state is CurrentResponseSurvey) {
        final current = (state as CurrentResponseSurvey);
        var questions = [...current.survey.questions];

        Question question = questions[current.index];

        var choices = <Choice>[...question.choices ?? []];

        if (!question.allowMultipleSelection) {
          for (int i = 0; i < choices.length; i++) {
            choices[i] = choices[i].copyWith(isSelected: false);
          }
        }

        for (int i = 0; i < choices.length; i++) {
          if (choices[i].choiceId == event.choice.choiceId) {
            choices[i] = choices[i].copyWith(
              isSelected: event.choice.isSelected,
            );
          }
        }

        questions[current.index] = question.copyWith(choices: choices);

        emit(
          CurrentResponseSurvey(
            current.survey.copyWith(questions: questions),
            current.index,
          ),
        );
      }
    });
  }
}
