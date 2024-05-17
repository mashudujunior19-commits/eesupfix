import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'survey_response_event.dart';
part 'survey_response_state.dart';

class SurveyResponseBloc
    extends Bloc<SurveyResponseEvent, SurveyResponseState> {
  SurveyResponseBloc() : super(SurveyResponseInitial()) {
    on<SurveyResponseEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
