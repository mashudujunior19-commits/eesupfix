part of 'hamper_bloc.dart';

@immutable
sealed class HamperState {}

final class HamperInitial extends HamperState {}

class HamperLoading extends HamperState {}

class HamperLoaded extends HamperState {
  final Hamper hamper;
  HamperLoaded(this.hamper);
}

class HampersLoaded extends HamperState {
  final List<Hamper> hampers;
  final List<Product>? products;

  HampersLoaded(this.hampers, {this.products});
}

class HamperProductLoaded extends HamperState {
  final List<HamperProductDetail> hamperProductDetails;

  HamperProductLoaded(this.hamperProductDetails);
}

class HamperError extends HamperState {
  final String message;

  HamperError(this.message);
}

class HamperNotFound extends HamperState {}
// class HamperComparisonSuccess extends HamperState {
//   final Hamper matchingHamper;

//   HamperComparisonSuccess(this.matchingHamper);
// }

// class HamperComparisonResultState extends HamperState {
//   final Product? hamperProduct;
//   //final Hamper matchingHamper;
//   // final List<OrderProduct> nonMatchingProducts;

//   HamperComparisonResultState({
//     required this.hamperProduct,
//     // required this.matchingHamper,
//     // required this.nonMatchingProducts,
//   });
// }

class HamperAddedToCart extends HamperState {
  final List<OrderProduct> updatedCartProducts;
  HamperAddedToCart(this.updatedCartProducts);
}

//class HamperComparisonFailure extends HamperState {}

class HamperAsProductLoaded extends HamperState {
  final Product hamperProduct;
  HamperAsProductLoaded(this.hamperProduct);
}

class HamperIdLoaded extends HamperState {
  final String hamperId;
  HamperIdLoaded(this.hamperId);
}
