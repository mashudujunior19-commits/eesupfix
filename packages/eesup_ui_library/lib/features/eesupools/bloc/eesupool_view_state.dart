part of 'eesupool_view_bloc.dart';

@immutable
sealed class EESUpoolViewState {}

 final class EESUpoolViewLoading extends EESUpoolViewState {}

final class CurrentEESUpool extends EESUpoolViewState {
  final EESUpool eesupool;

  CurrentEESUpool(this.eesupool);
}