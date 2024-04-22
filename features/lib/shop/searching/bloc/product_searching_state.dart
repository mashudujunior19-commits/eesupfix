part of 'product_searching_bloc.dart';

@immutable
sealed class ProductSearchingState {}

final class ProductSearchingInitial extends ProductSearchingState {}

final class ProductSearchingError extends ProductSearchingState {
  final EESUpException exception;
  ProductSearchingError(this.exception);
}

final class ProductSearchingResults extends ProductSearchingState {
  final Map<String, dynamic> results;
  ProductSearchingResults(this.results);
}
