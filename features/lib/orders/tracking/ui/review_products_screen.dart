import 'package:auto_route/auto_route.dart';
import 'package:data_sources/orders/models/order.dart';
import 'package:data_sources/orders/models/order_product.dart';
import 'package:features/core/extensions/bg_image_deco_ext.dart';
import 'package:features/core/extensions/context_alerts_ext.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/orders/tracking/bloc/review_order_products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

@RoutePage()
class ReviewProductsScreen extends StatelessWidget {
  const ReviewProductsScreen({
    super.key,
    required this.privilage,
    required this.order,
  });
  final OrderEditPrivilage privilage;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewOrderProductsBloc()
        ..add(
          ReviewOrderProductsInitialized(order),
        ),
      child: SafeArea(
        child: BlocBuilder<ReviewOrderProductsBloc, ReviewOrderProductsState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: BackButton(
                  onPressed: () {
                    if (state is ReviewOrderProductsCurrentState) {
                      if (!state.isBalanced()) {
                        context.showAlertDialog(
                          'Issues',
                          privilage == OrderEditPrivilage.owner
                              ? 'One or more items have not been accepted,'
                                  ' Do you wish to open an issue.'
                              : 'One or more items have not been packaged,'
                                  ' Do you wish to open an issue.',
                          negativeColor: context.colorScheme.error,
                          positiveColor: context.colorScheme.primary,
                          positiveText: 'Open an issue',
                          negativeText: 'Cancel',
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
                title: const Text('REVIEW ITEMS'),
              ),
              body: Container(
                decoration: context.bgImage,
                height: context.height,
                width: context.width,
                child: () {
                  if (state is ReviewOrderProductsCurrentState) {
                    final products = state.order.products;
                    return ListView.builder(
                      padding: const EdgeInsets.only(bottom: 400),
                      itemBuilder: (context, index) {
                        return _ProductCard(
                          product: products[index],
                          privilage: privilage,
                        );
                      },
                      itemCount: products.length,
                    );
                  } else {
                    return const SizedBox();
                  }
                }(),
              ),
              bottomNavigationBar: () {
                if (state is ReviewOrderProductsCurrentState) {
                  if (!state.isBalanced()) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 25),
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Colors.redAccent,
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('Open an issue'),
                      ).animate().slideIn(0),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 25),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              context.colorScheme.primary),
                        ),
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Text('Accept all items'),
                      ).animate().slideIn(0),
                    );
                  }
                }
              }(),
            );
          },
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.privilage, required this.product});
  final OrderEditPrivilage privilage;
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
              'R${(product.price * product.quantity).toStringAsFixed(2)} (${product.quantity})',
              style: context.textTheme.labelMedium,
            ),
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    if (privilage == OrderEditPrivilage.owner) {
                      final newQty = product.customerAcceptedQty - 1;
                      if (newQty > -1) {
                        context.read<ReviewOrderProductsBloc>().add(
                              OrderProductReviewEdited(
                                product.copyWith(customerAcceptedQty: newQty),
                              ),
                            );
                      }
                    } else {
                      final newQty = product.eesupreneurAcceptedQty - 1;
                      if (newQty > -1) {
                        context.read<ReviewOrderProductsBloc>().add(
                              OrderProductReviewEdited(
                                product.copyWith(
                                    eesupreneurAcceptedQty: newQty),
                              ),
                            );
                      }
                    }
                  },
                  icon: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/mark.png',
                      width: 22,
                      color: Colors.red.shade400,
                    ),
                  ),
                ),

                ///THE PACKAGING STATUS CHECKBOX USES PRIVILLAGE TO ENSURE THAT
                ///THE APPROPRIATE QUANTIY OF ACCEPTANCE IS UPDATE BUT NOT BOTH
                ///EITHER THE IS IT THE CUSTOMER ACCECPTING OR THE PERSON RESPONSIBLE TO PACKING/ALL
                Container(
                  width: 30,
                  margin: const EdgeInsets.only(top: 2),
                  child: TextFormField(
                    controller: TextEditingController(
                      text: privilage == OrderEditPrivilage.owner
                          ? product.customerAcceptedQty.toString()
                          : product.eesupreneurAcceptedQty.toString(),
                    ),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: context.textTheme.labelMedium,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    onFieldSubmitted: (value) {
                      final qty = int.tryParse(value);

                      if (qty != null) {
                        if (qty > product.quantity || qty < 0) {
                          context.snackBarError(
                            "The quantity must be between 0 and the total quantity ${product.quantity}",
                          );
                          context.read<ReviewOrderProductsBloc>().add(
                                OrderProductReviewEdited(product),
                              );
                        } else {
                          context.read<ReviewOrderProductsBloc>().add(
                                privilage == OrderEditPrivilage.owner
                                    ? OrderProductReviewEdited(
                                        product.copyWith(
                                            customerAcceptedQty: qty),
                                      )
                                    : OrderProductReviewEdited(
                                        product.copyWith(
                                            eesupreneurAcceptedQty: qty),
                                      ),
                              );
                        }
                      }
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (privilage == OrderEditPrivilage.owner) {
                      final newQty = product.customerAcceptedQty + 1;
                      if (newQty <= product.quantity) {
                        context.read<ReviewOrderProductsBloc>().add(
                              OrderProductReviewEdited(
                                product.copyWith(customerAcceptedQty: newQty),
                              ),
                            );
                      }
                    } else {
                      final newQty = product.eesupreneurAcceptedQty + 1;
                      if (newQty <= product.quantity) {
                        context.read<ReviewOrderProductsBloc>().add(
                              OrderProductReviewEdited(
                                product.copyWith(
                                    eesupreneurAcceptedQty: newQty),
                              ),
                            );
                      }
                    }
                  },
                  icon: const Icon(IconlyLight.plus),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
