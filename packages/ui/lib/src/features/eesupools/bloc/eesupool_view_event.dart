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
  final bool canSave;
  EESUpoolSettingsUpdated(this.pool, this.canSave);
}
