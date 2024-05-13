import 'package:auto_route/auto_route.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/eesupools/models/eesupool_order.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:ui/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:ui/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/eesupools/ui/tabs/members/ui/member_card.dart';
import 'package:ui/eesupools/ui/tabs/members/ui/select_member_dialog.dart';
import 'package:ui/eesupools/ui/tabs/orders/bloc/order_receivers_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:data/utils/eesup_exception.dart';

@RoutePage()
class OrderReceiverScreen extends StatelessWidget {
  const OrderReceiverScreen({
    super.key,
    required this.order,
    required this.pool,
    required this.ids,
  });
  final EESUpool pool;
  final EESUpoolOrder order;
  final List<String> ids;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrderReceiversBloc(context.read<EESUpoolRepository>())
            ..add(OrderReceiversFetched(ids)),
      child: BlocBuilder<OrderReceiversBloc, OrderReceiversState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                leading: const BackButton(),
                title: const Text('ORDER RECEIVERS'),
                actions: [
                  if (order.deliveredAt == null)
                    IconButton(
                      onPressed: () {
                        context
                            .showBottomSheetDialog(
                                child: SelectMemberDialog(pool: pool))
                            .then((value) {
                          if (value != null) {
                            if (value is EESUpoolMember) {
                              context.read<OrderReceiversBloc>().add(
                                    OrderReceiverAdded(order.id, value),
                                  );
                            }
                          }
                        });
                      },
                      icon: const Icon(Icons.add),
                    ),
                ],
              ),
              body: Container(
                decoration: context.bgImage,
                height: context.height,
                child: BlocBuilder<OrderReceiversBloc, OrderReceiversState>(
                  builder: (context, state) {
                    if (state is OrderReceiversLoading) {
                      return const FullScreenLoadingShimmer();
                    } else if (state is OrderReceiversLoaded) {
                      final members = state.receivers;
                      return Column(
                        children: [
                          if (order.deliveredAt != null)
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 22, right: 22),
                              child: Text(
                                'Once the order has been received the receivers cannot be modified.',
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontSize: 11.5,
                                ),
                              ),
                            ),
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              itemBuilder: (context, index) {
                                return MemberCard(
                                  member: members[index],
                                  pool: pool,
                                  trailing: order.deliveredAt == null
                                      ? InkWell(
                                          onTap: () {
                                            context
                                                .read<OrderReceiversBloc>()
                                                .add(OrderReceiverRemoved(
                                                    order.id, members[index]));
                                          },
                                          child: const Icon(
                                            IconlyLight.delete,
                                            size: 20,
                                            color: Colors.red,
                                          ),
                                        )
                                      : null,
                                );
                              },
                              itemCount: members.length,
                            ),
                          ),
                        ],
                      );
                    } else if (state is OrderReceiversError) {
                      return FullScreenError(exception: state.error);
                    } else {
                      return FullScreenError(
                        exception: EESUpException(message: ''),
                      );
                    }
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
