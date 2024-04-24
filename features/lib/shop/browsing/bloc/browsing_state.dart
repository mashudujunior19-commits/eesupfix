part of 'browsing_bloc.dart';

@immutable
sealed class BrowsingState {}

final class BrowsingInitial extends BrowsingState {}

final class BrowsingError extends BrowsingState {
  final EESUpException exception;
  BrowsingError(this.exception);
}

final class BrowsingSearchResults extends BrowsingState {
  final Map<String, dynamic> results;
  BrowsingSearchResults(this.results);
}
