import 'package:auto_route/auto_route.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/views/shop/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            context.router.push(CartRoute());
          },
          icon: Badge(
            backgroundColor: context.colorScheme.primary,
            label: Text(
              (state as CurrentCart).totalQty().toString(),
              style: context.textTheme.labelMedium?.copyWith(
                color: Colors.white,
              ),
            ),
            child: const Icon(IconlyLight.buy),
          ),
        );
      },
    );
  }
}
