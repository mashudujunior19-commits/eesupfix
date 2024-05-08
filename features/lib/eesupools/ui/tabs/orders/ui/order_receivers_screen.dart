import 'package:auto_route/auto_route.dart';
import 'package:features/eesupools/ui/tabs/orders/bloc/order_receivers_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/eesupools/eesupool_repo.dart';

@RoutePage()
class OrderReceiverScreen extends StatelessWidget {
  const OrderReceiverScreen({super.key, required this.ids});
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
              ),
            ),
          );
        },
      ),
    );
  }
}
