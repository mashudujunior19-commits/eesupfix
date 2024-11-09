// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../bloc/checkout_bloc.dart';

// class OrderProductList extends StatelessWidget {
//   const OrderProductList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<CheckoutBloc, CheckoutState>(
//         listener: (BuildContext context, CheckoutState state) {
//       if (state is CheckoutLoading) {
//         context.loaderOverlay.show();
//       } else {
//         context.loaderOverlay.hide();
//       }
//  builder: (BuildContext context, CheckoutState state) {  
    
//     ListView(
//         padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(10),
//                 topRight: Radius.circular(10),
//               ),
//             ),
//             child: Column(
//               children: [
//                 const Text('Order Summary'),
//                 20.sH,
//                 _LineTile(
//                   label: 'Payment method',
//                   value: newOrder?.paymentMethod.toString() ?? "No selected",
//                 ),
//                 // _LineTile(
//                 //   label: 'Discount',
//                 //   value: 'R${discount.toStringAsFixed(2)}',
//                 // ),
//                 _LineTile(
//                   label: 'Subtotal',
//                   value: 'R${newOrder?.value.toStringAsFixed(2) ?? '0.00'}',
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     _LineTile(
//                       label: 'Card fee',
//                       isVisible: newOrder?.cardFee != null,
//                       value:
//                           'R${newOrder?.cardFee?.toStringAsFixed(2) ?? '0.00'}',
//                     ),
//                     if (newOrder?.paymentMethod != PaymentMethod.retailWallet)
//                       GestureDetector(
//                         onTap: () {
//                           final value =
//                               !(newOrder?.payFeesWithRetailWallet ?? false);
//                           context
//                               .read<CheckoutBloc>()
//                               .add(PayFeesWithWalletUpdated(value));
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   '**Tap to Pay the fee with you Retail wallet',
//                                   style: context.textTheme.labelSmall?.copyWith(
//                                     fontSize: 13,
//                                     fontStyle: FontStyle.italic,
//                                     color: Colors.grey.shade700,
//                                   ),
//                                 ),
//                               ),
//                               Checkbox(
//                                 value:
//                                     newOrder?.payFeesWithRetailWallet ?? false,
//                                 onChanged: (value) {
//                                   context.read<CheckoutBloc>().add(
//                                         PayFeesWithWalletUpdated(
//                                             value ?? false),
//                                       );
//                                 },
//                                 visualDensity: VisualDensity.compact,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     15.sH,
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 25),
//             padding: const EdgeInsets.all(10),
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(10),
//                 topRight: Radius.circular(10),
//               ),
//             ),
//             child: Column(
//               children: [
//                 _LineTile(
//                   label: 'Delivery fee',
//                   value:
//                       "R${newOrder?.deliveryFee?.toStringAsFixed(2) ?? 0.00}",
//                 ),
//                 _LineTile(
//                   label: 'Total',
//                   value: "R${total?.toStringAsFixed(2) ?? 0.00}",
//                   isBold: true,
//                 ),
//               ],
//             ),
//           ),
//           Image.asset("assets/images/receipt_bottom.png"),
//           30.sH,
//           ElevatedButton(
//             onPressed: () {
//               context.read<CheckoutBloc>().add(OrderPlaced());
//             },
//             child: const Text("Place order"),
//           )
//         ],
//       );
//   },}
// }