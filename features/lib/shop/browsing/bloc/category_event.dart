part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

final class CategoryProductAndDescendentsFetched extends CategoryEvent {
  final int id;
  CategoryProductAndDescendentsFetched(this.id);
}
