import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ui/src/views/geolocation/models/address_suggestion.dart';

part 'auto_completion_event.dart';
part 'auto_completion_state.dart';

class AutoCompletionBloc
    extends Bloc<AutoCompletionEvent, AutoCompletionState> {
  AutoCompletionBloc() : super(AutoCompletionInitial()) {
    on<AutoCompletionRequested>((event, emit) async {
      emit(AutoCompletionLoading());
      try {
        final results = await _predictions(event.key, event.input);
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

  // Geoapify's Autocomplete API sends CORS headers (unlike Google's Places
  // REST API), so it can be called directly from the browser on web and
  // natively on mobile with the same code path.
  Future<List<AddressSuggestion>> _predictions(String key, String input) async {
    final uri = Uri.https('api.geoapify.com', '/v1/geocode/autocomplete', {
      'text': input,
      'filter': 'countrycode:za',
      'apiKey': key,
    });
    final response = await http.get(uri);
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final features = (body['features'] as List?) ?? const [];
    return features
        .map((f) {
          final properties = f['properties'] as Map<String, dynamic>;
          return AddressSuggestion(
            address: properties['formatted'] as String,
            lat: (properties['lat'] as num).toDouble(),
            lng: (properties['lon'] as num).toDouble(),
          );
        })
        .toList();
  }
}
