part of 'eesupool_view_bloc.dart';

@immutable
sealed class EESUpoolViewState {}

final class CurrentEESUpoolView extends EESUpoolViewState {
  final EESUpool eesupool;
  CurrentEESUpoolView(this.eesupool);
}

final class EESUpoolViewLoading extends EESUpoolViewState {}

final class EESUpoolViewError extends EESUpoolViewState {
  final EESUpException exception;
  EESUpoolViewError(this.exception);
}
