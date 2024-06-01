part of 'categories_bloc.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoadingError extends CategoriesState {
  final EESUpException exception;
  CategoriesLoadingError(this.exception);
}

final class CategoriesLoaded extends CategoriesState {
  final List<Category> categories;
  CategoriesLoaded(this.categories);
}
