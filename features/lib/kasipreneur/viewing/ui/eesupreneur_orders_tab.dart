import 'package:data_sources/orders/models/order.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/orders/listing/ui/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// final eesupreneurOrdersProvider =
//     StreamProvider.autoDispose<List<Order>>((ref) async* {
//   final repo = ref.read(ordersRepoProvider);
//   final status = ref.watch(orderShopStatusProvider);
//   final currentShopId = ref.watch(eesupreneurViewProvider)?.id;
//   if (currentShopId == null) throw EESUpException(message: 'Shop not found');
//   final limit = ref.watch(orderLimitProvider);
//   final result = repo.streamShopOrders(
//     statuses: status,
//     shopId: currentShopId,
//     limit: limit,
//   );
//   await for (final orders in result) {
//     yield* orders.fold((l) {
//       throw l;
//     }, (r) async* {
//       yield r;
//     });
//   }
// });

class EESUpreneurOrdersTab extends StatelessWidget {
  const EESUpreneurOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    List<Order> orders = [];
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 300),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return OrderCard(
                order: order,
                privilege: OrderEditPrivilage.all,
              ).animate().slideIn(index * 50);
            },
          ),
        )
      ],
    );
  }
}
