part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

final class ProductAddedToCart extends CartEvent {
  final OrderProduct product;
  ProductAddedToCart(this.product);
}

final class ProductDecrementedFromCart extends CartEvent {
  final int id;
  ProductDecrementedFromCart(this.id);
}

final class ProductRemovedFromCart extends CartEvent {
  final int id;
  ProductRemovedFromCart(this.id);
}

final class CartCleared extends CartEvent {
  CartCleared();
}

final class ProductSubsitutesUpdated extends CartEvent {
  final int id;
  final bool substituteBrand;
  final bool substituteVariant;
  ProductSubsitutesUpdated({
    required this.id,
    required this.substituteBrand,
    required this.substituteVariant,
  });
}


final class ProductSettingsExpanded extends CartEvent {
  final int id;
  final bool isExpanded;
  ProductSettingsExpanded(this.id,this.isExpanded);
}


