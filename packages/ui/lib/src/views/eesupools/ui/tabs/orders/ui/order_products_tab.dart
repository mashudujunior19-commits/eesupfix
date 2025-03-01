import 'package:data/eesupools/repository/eesupool_orders_repo.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:data/orders/models/order_product.dart';
import 'package:data/utils/double_ext.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';

class OrderProductsTab extends StatelessWidget {
  const OrderProductsTab({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Either<EESUpException, List<OrderProduct>>>(
      future: context.read<EESUpoolRepository>().fetchPoolOrderProducts(id),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const FullScreenLoadingShimmer();
        } else if (snap.data != null) {
          final data = snap.data;
          return data?.fold(
                (l) {
                  return FullScreenError(exception: l);
                },
                (r) {
                  if (r.isEmpty) {
                    return FullScreenError(
                      exception: EESUpException(
                          message: 'Members have not placed orders yet.'),
                      isError: false,
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 300),
                    itemBuilder: (context, index) {
                      return _ProductCard(product: r[index]);
                    },
                    itemCount: r.length,
                  );
                },
              ) ??
              FullScreenError(
                exception: EESUpException(message: ''),
                isError: false,
              );
        } else {
          return FullScreenError(
            exception: EESUpException(message: ''),
            isError: false,
          );
        }
      },
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});
  final OrderProduct product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 17, left: 17, top: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
          width: .5,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 5),
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: product.imageUrl != null
              ? Image.network(product.imageUrl!, width: 27)
              : Image.asset(
                  'assets/images/no-photo.png',
                  width: 27,
                  color: Colors.grey,
                ),
        ),
        title: Text(
          product.name,
          style: context.textTheme.labelMedium?.copyWith(fontSize: 13),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${product.category}',
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
            if (product.size != null)
              Text(
                '${product.size}',
                style: context.textTheme.labelSmall?.copyWith(
                  color: Colors.grey.shade500,
                  fontSize: 11.5,
                ),
              ),
            const SizedBox(height: 2),
            Text(
              'R${(product.price * product.quantity).toRounded()} (${product.quantity})',
              style: context.textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
