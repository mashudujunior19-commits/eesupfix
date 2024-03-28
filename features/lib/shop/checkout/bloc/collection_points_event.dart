part of 'collection_points_bloc.dart';

@immutable
sealed class CollectionPointsEvent {}

final class CollectionPointsRequested extends CollectionPointsEvent {
  final Address? address;
  CollectionPointsRequested(this.address);
}
