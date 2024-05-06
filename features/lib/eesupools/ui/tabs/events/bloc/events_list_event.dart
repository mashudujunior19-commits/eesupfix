part of 'events_list_bloc.dart';

@immutable
sealed class EventsListEvent {}

final class EventsFetched extends EventsListEvent {
  final int eesupoolId;
  final int limit;
  EventsFetched(this.eesupoolId,this.limit);
}
