part of 'hamper_bloc.dart';

@immutable
sealed class HamperState {}

final class HamperInitial extends HamperState {}

class HamperLoading extends HamperState {}

class HamperLoaded extends HamperState {
  final List<Hamper> hampers;
  final List<Product>? products;

  HamperLoaded(this.hampers, {this.products});
}

class HamperProductLoaded extends HamperState {
  final List<HamperProductDetail> hamperProductDetails;

  HamperProductLoaded(this.hamperProductDetails);
}

class HamperError extends HamperState {
  final String message;

  HamperError(this.message);
}
