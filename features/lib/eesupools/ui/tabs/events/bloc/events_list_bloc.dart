import 'package:bloc/bloc.dart';
import 'package:data_sources/eesupools/models/eesupool_event.dart';
import 'package:meta/meta.dart';
import 'package:repository/eesupools/eesupool_repo.dart';
import 'package:repository/utils/eesup_exception.dart';
import 'package:repository/eesupools/eesupool_events_repo.dart';

part 'events_list_event.dart';
part 'events_list_state.dart';

class EventsListBloc extends Bloc<EventsListEvent, EventsListState> {
  final EESUpoolRepository _repository;
  EventsListBloc(this._repository) : super(EventsListLoading()) {
    on<EventsFetched>((event, emit) async {
      emit(EventsListLoading());
      final results = await _repository.fetchEESUpoolEvents(
        event.eesupoolId,
        event.limit,
      );
      results.fold((left) {
        emit(EventsListError(left));
      }, (right) {
        emit(EventsListLoaded(right));
      });
    });
  }
}
