part of 'my_kasi_tree_bloc.dart';

@immutable
sealed class MyKasiTreeEvent {}

final class MyKasiTreeFetched extends MyKasiTreeEvent {
  final int parentId;
  MyKasiTreeFetched(this.parentId);
}
