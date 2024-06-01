part of 'events_list_bloc.dart';

@immutable
sealed class EventsListState {}

final class EventsListLoading extends EventsListState {}

final class EventsListLoaded extends EventsListState {
  final List<EESUpoolEvent> events;
  EventsListLoaded(this.events);
}

final class EventsListError extends EventsListState {
  final EESUpException error;
  EventsListError(this.error);
}
