part of 'collection_points_bloc.dart';

@immutable
sealed class CollectionPointsState {}

final class CollectionPointsLoading extends CollectionPointsState {}

final class CollectionPointsLoaded extends CollectionPointsState {
  final List<EESUpreneur> shops;
  final List<EESUpoolOrder> orders;
  CollectionPointsLoaded(this.shops, this.orders);
}
