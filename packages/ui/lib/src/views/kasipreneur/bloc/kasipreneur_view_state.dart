part of 'kasipreneur_view_bloc.dart';

@immutable
sealed class KasipreneurViewState {}

final class KasipreneurViewLoading extends KasipreneurViewState {}

final class KasipreneurViewCurrentState extends KasipreneurViewState {
  final EESUpreneur eesupreneur;
  KasipreneurViewCurrentState(this.eesupreneur);
}

final class KasipreneurViewError extends KasipreneurViewState {
  final EESUpException error;
  KasipreneurViewError(this.error);
}
