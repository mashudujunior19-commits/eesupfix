import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/shopping/models/basket.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/features/shop/baskets/bloc/basket_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:data/utils/eesup_exception.dart';

@RoutePage()
class BasketsListScreen extends StatelessWidget {
  const BasketsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BasketListBloc(
        context.read<ShoppingRepository>(),
      )..add(BasketListsFetched()),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: const Text('My Baskets'),
            actions: [
              IconButton(
                onPressed: () {
                  // createBasketDialog(context).whenComplete(() {
                  //   // ref.invalidate(basketsProvider);
                  // });
                },
                icon: const Icon(IconlyLight.plus),
              ),
              10.sW,
            ],
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: context.bgImage,
            child: BlocBuilder<BasketListBloc, BasketListState>(
              builder: (context, state) {
                if (state is BasketListError) {
                  return FullScreenError(exception: state.exception);
                } else if (state is BasketListLoading) {
                  return const FullScreenLoadingShimmer();
                } else if (state is BasketListEmpty) {
                  return FullScreenError(
                    isError: false,
                    exception: EESUpException(
                      message: 'you don\'t have baskets yet',
                    ),
                  );
                } else if (state is BasketListLoaded) {
                  final baskets = state.baskets;
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 300),
                    itemCount: baskets.length,
                    itemBuilder: (context, index) {
                      final basket = baskets[index];
                      return _BasketCard(basket: basket)
                          .animate()
                          .slideIn(index * 50);
                    },
                  );
                } else {
                  return FullScreenError(
                    exception: EESUpException(
                      message: 'Something went wrong'
                          ' while fetching your baskets',
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _BasketCard extends StatelessWidget {
  const _BasketCard({required this.basket});
  final Basket basket;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return InkWell(
      onTap: () {
        context.router.push(BasketViewRoute(basket: basket)).whenComplete(() {});
      },
      child: Container(
        margin: const EdgeInsets.only(right: 21, left: 19, top: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.shade300,
            width: .5,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 10, right: 5),
          leading: CircleAvatar(
            backgroundColor: colorScheme.primary.withOpacity(.1),
            child: Icon(
              BootstrapIcons.basket,
              color: colorScheme.primary,
              size: 20,
            ),
          ),
          title: Text(basket.name),
          subtitle: Text(
            basket.type?.name ?? 'Custom Basket',
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.primary,
            ),
          ),
          trailing: const Icon(
            IconlyLight.arrowRight2,
            size: 18,
          ),
        ),
      ),
    );
  }
}
