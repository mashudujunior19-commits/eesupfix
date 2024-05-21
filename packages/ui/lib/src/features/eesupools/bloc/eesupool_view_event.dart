part of 'eesupool_view_bloc.dart';

@immutable
sealed class EESUpoolViewEvent {}

final class EESUpoolViewLoaded extends EESUpoolViewEvent {
  final int? id;
  final EESUpool? eesupool;
  EESUpoolViewLoaded({this.id, this.eesupool});
}

final class EESUpoolSettingsUpdated extends EESUpoolViewEvent {
  final EESUpool pool;
  EESUpoolSettingsUpdated(this.pool);
}

final class EESUpoolPercentagesUpdated extends EESUpoolViewEvent {
  final EESUpool pool;

  EESUpoolPercentagesUpdated(this.pool);
}
