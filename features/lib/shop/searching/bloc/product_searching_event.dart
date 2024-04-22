part of 'product_searching_bloc.dart';

@immutable
sealed class ProductSearchingEvent {}

final class ProductsSearched extends ProductSearchingEvent {
  final String input;
  final int limit;
  ProductsSearched(this.input,this.limit);
}
