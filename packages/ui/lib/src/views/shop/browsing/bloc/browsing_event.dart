part of 'browsing_bloc.dart';

@immutable
sealed class BrowsingEvent {}

final class ProductsSearched extends BrowsingEvent {
  final String input;
  final int limit;
  ProductsSearched(this.input, this.limit);
}
