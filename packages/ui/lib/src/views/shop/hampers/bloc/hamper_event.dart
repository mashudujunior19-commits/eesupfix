part of 'hamper_bloc.dart';

@immutable
sealed class HamperEvent {}

class FetchHampers extends HamperEvent {}

class FetchHamper extends HamperEvent {
  final String hamperId;
  FetchHamper(this.hamperId);
}

class FetchHampersByImageUrl extends HamperEvent {
  final String imageUrl;
  FetchHampersByImageUrl(this.imageUrl);
}

class FetchHamperProducts extends HamperEvent {
  final String hamperId;
  FetchHamperProducts(this.hamperId);
}

class FetchHamperAsProduct extends HamperEvent {
  final String hamperId;
  FetchHamperAsProduct(this.hamperId);
}

class FetchHamperProductsByImageUrl extends HamperEvent {
  final String imageUrl;

  FetchHamperProductsByImageUrl(this.imageUrl);
}

class CompareCartWithHampers extends HamperEvent {
  final List<OrderProduct> cartProducts;
  CompareCartWithHampers(this.cartProducts);
}

class AddHamperToCart extends HamperEvent {
  final String hamperId;
  final List<OrderProduct> cartProducts;

  AddHamperToCart(this.hamperId, this.cartProducts);
}

class ResetHamperComparison extends HamperEvent {}
