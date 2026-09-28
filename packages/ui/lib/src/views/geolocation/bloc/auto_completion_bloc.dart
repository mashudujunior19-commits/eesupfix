import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_google_place_search/flutter_google_place_search.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ui/src/views/geolocation/models/address_suggestion.dart';

part 'auto_completion_event.dart';
part 'auto_completion_state.dart';

class AutoCompletionBloc
    extends Bloc<AutoCompletionEvent, AutoCompletionState> {
  AutoCompletionBloc() : super(AutoCompletionInitial()) {
    on<AutoCompletionRequested>((event, emit) async {
      emit(AutoCompletionLoading());
      try {
        final results = kIsWeb
            ? await _webPredictions(event.input)
            : await _nativePredictions(event.key, event.input);
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

  // Google's Places Autocomplete/Geocoding REST APIs don't send CORS
  // headers, so browser fetches to maps.googleapis.com fail on web. This
  // routes web through a Supabase edge function that calls Google
  // server-side instead. Native builds aren't subject to CORS and keep
  // calling Google directly below.
  Future<List<AddressSuggestion>> _webPredictions(String input) async {
    final response = await Supabase.instance.client.functions.invoke(
      'google-places',
      body: {'action': 'autocomplete', 'input': input, 'region': 'za'},
    );
    final data = response.data as List;
    return data
        .map(
          (e) => AddressSuggestion(
            address: e['address'] as String,
            lat: (e['lat'] as num).toDouble(),
            lng: (e['lng'] as num).toDouble(),
          ),
        )
        .toList();
  }

  Future<List<AddressSuggestion>> _nativePredictions(
    String key,
    String input,
  ) async {
    final places =
        await FlutterGooglePlace(key: key, region: 'za').getPredictions(
      input,
    );
    return places
        .map(
          (p) => AddressSuggestion(address: p.address, lat: p.lat, lng: p.lng),
        )
        .toList();
  }
}
