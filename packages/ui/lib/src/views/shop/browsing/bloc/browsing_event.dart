part of 'browsing_bloc.dart';

@immutable
sealed class BrowsingEvent {}

final class ProductsSearched extends BrowsingEvent {
  final String input;
  final int limit;
  ProductsSearched(this.input, this.limit);
}

/// The search text was cleared (or is too short to search): go back to
/// browsing categories.
final class SearchCleared extends BrowsingEvent {}
