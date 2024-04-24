part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  final List<Product> products;
  final List<Category> descendents;
  CategoryLoaded(this.products, this.descendents);
}
