// class HamperComparer {
//   final List<OrderProduct> cartProducts;
//   final List<Hamper> hampers;

//   HamperComparer({required this.cartProducts, required this.hampers});

//   List<Hamper> findMatchingHampers() {
//     // This will hold the hampers that match the cart products
//     List<Hamper> matchingHampers = [];

//     for (final hamper in hampers) {
//       // Fetch hamper products to compare against cart products
//       final hamperProducts = fetchHamperProducts(hamper.id);

//       // Check if all hamper products exist in the cart
//       if (areAllProductsInCart(hamperProducts, cartProducts)) {
//         matchingHampers.add(hamper);
//       }
//     }

//     return matchingHampers;
//   }

//   List<Product> fetchHamperProducts(String hamperId) {
//     // You would replace this stub with the actual logic to fetch products for the hamper
//     // This could be done using the HamperRepository
//     return []; // Return a list of products for the given hamper
//   }

//   bool areAllProductsInCart(List<Product> hamperProducts, List<OrderProduct> cartProducts) {
//     // Create a set of product IDs in the cart for quick lookup
//     final cartProductIds = cartProducts.map((product) => product.productId).toSet();

//     // Check if all hamper products are in the cart
//     return hamperProducts.every((product) => cartProductIds.contains(product.id));
//   }
// }


// void checkForMatchingHampers(BuildContext context) {
//   final cartState = context.read<CartBloc>().state;
//   final cartProducts = (cartState as CurrentCart).products;

//   // Assuming you have a method in your HamperBloc to get the current hampers
//   final hamperState = context.read<HamperBloc>().state;
//   List<Hamper> hampers;

//   if (hamperState is HamperLoaded) {
//     hampers = hamperState.hampers;

//     // Create an instance of HamperComparer
//     final comparer = HamperComparer(cartProducts: cartProducts, hampers: hampers);

//     // Find matching hampers
//     final matchingHampers = comparer.findMatchingHampers();

//     // Now you can use matchingHampers as needed (e.g., display them in the UI)
//     if (matchingHampers.isNotEmpty) {
//       // Do something with the matching hampers
//       print('Matching hampers found: ${matchingHampers.length}');
//     } else {
//       print('No matching hampers found.');
//     }
//   }
// }
