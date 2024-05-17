part of 'my_kasi_tree_bloc.dart';

@immutable
sealed class MyKasiTreeState {}

final class MyKasiTreeLoading extends MyKasiTreeState {}

final class MyKasiTreeLoaded extends MyKasiTreeState {
  final List<EESUpool> pools;
  MyKasiTreeLoaded(this.pools);
}

final class MyKasiTreeError extends MyKasiTreeState {
  final EESUpException exception;
  MyKasiTreeError(this.exception);
}
