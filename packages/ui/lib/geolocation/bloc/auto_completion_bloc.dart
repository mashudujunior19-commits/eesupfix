import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_google_place_search/flutter_google_place_search.dart';

part 'auto_completion_event.dart';
part 'auto_completion_state.dart';

class AutoCompletionBloc
    extends Bloc<AutoCompletionEvent, AutoCompletionState> {
  AutoCompletionBloc() : super(AutoCompletionInitial()) {
    on<AutoCompletionRequested>((event, emit) async {
      emit(AutoCompletionLoading());
      try {
        print(event.key);
        final results = await FlutterGooglePlace(key: event.key, region: 'za')
            .getPredictions(
          event.input,
        );
        print(results);
        emit(AutoCompletionsLoaded(results));
      } catch (e) {
        if (kDebugMode) {
          print('Autocomplete bloc $e');
        }
        emit(AutoCompletionsLoaded(const []));
      }
    });
    on<AutoCompletionReseted>((event, emit) {
      emit(AutoCompletionInitial());
    });
  }
}
