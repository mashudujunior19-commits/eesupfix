part of 'applications_bloc.dart';

@immutable
sealed class ApplicationsEvent {}

final class ApplicationsFetched extends ApplicationsEvent {
  final String id;
  ApplicationsFetched(this.id);
}
