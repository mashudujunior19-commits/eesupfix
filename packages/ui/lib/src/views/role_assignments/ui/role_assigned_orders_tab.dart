import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/role_assignments/models/role_assigned_order.dart';
import 'package:data/role_assignments/repository/role_assignments_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/utils/date_formatter.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/views/kasipreneur/ui/kasipreneur_tab.dart';

/// "Role Assigned Orders" in My Economy: the KasiPool orders the user has a
/// role on (opening each one's checklist) and the KasiPreneurs they run.
class RoleAssignedOrdersTab extends StatelessWidget {
  const RoleAssignedOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              labelStyle: context.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
              labelColor: context.colorScheme.primary,
              unselectedLabelColor: Colors.black,
              indicatorColor: context.colorScheme.primary,
              tabs: const [Tab(text: 'KasiPools'), Tab(text: 'KasiPreneurs')],
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [_KasiPoolRoleOrders(), KasipreneurTab()],
            ),
          ),
        ],
      ),
    );
  }
}

class _KasiPoolRoleOrders extends StatefulWidget {
  const _KasiPoolRoleOrders();

  @override
  State<_KasiPoolRoleOrders> createState() => _KasiPoolRoleOrdersState();
}

class _KasiPoolRoleOrdersState extends State<_KasiPoolRoleOrders> {
  late Future<Either<EESUpException, List<RoleAssignedOrder>>> _future;

  @override
  void initState() {
    super.initState();
    _future = _fetch();
  }

  Future<Either<EESUpException, List<RoleAssignedOrder>>> _fetch() =>
      context.read<RoleAssignmentsRepository>().fetchMyRoleAssignedOrders();

  Future<void> _refresh() async {
    final future = _fetch();
    setState(() => _future = future);
    await future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        final result = snapshot.data;
        if (result == null) return const FullScreenLoadingShimmer();
        return result.fold(
          (l) => FullScreenError(exception: l),
          (orders) => RefreshIndicator(
            onRefresh: _refresh,
            child: orders.isEmpty
                ? ListView(
                    children: [
                      SizedBox(
                        height: 400,
                        child: FullScreenError(
                          isError: false,
                          exception: EESUpException(
                            message: 'You haven\'t been given a role on any '
                                'KasiPool orders yet.',
                          ),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 200),
                    itemCount: orders.length,
                    itemBuilder: (context, index) =>
                        _RoleOrderCard(order: orders[index]),
                  ),
          ),
        );
      },
    );
  }
}

class _RoleOrderCard extends StatelessWidget {
  const _RoleOrderCard({required this.order});

  final RoleAssignedOrder order;

  String get _title => order.isBulk
      ? '${order.eesupoolName} bulk order'
      : 'Order ${order.orderId} · ${order.eesupoolName}';

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(top: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        onTap: () => context.router.push(
          RoleChecklistRoute(
            eesupoolOrderId: order.eesupoolOrderId,
            orderId: order.orderId,
            title: _title,
            role: order.role,
          ),
        ),
        leading: Icon(
          order.isBulk ? BootstrapIcons.box_seam_fill : BootstrapIcons.box_seam,
          color: context.colorScheme.primary,
        ),
        title: Text(_title, style: context.textTheme.labelMedium),
        subtitle: Text(
          [
            order.role,
            if (!order.isBulk && order.customerName != null)
              'for ${order.customerName}',
            if (order.deliveredAt != null)
              'received'
            else if (order.scheduleFor != null)
              'due ${DateFormatter.formatDateToNameday(order.scheduleFor!)}',
          ].join('  ·  '),
          style: context.textTheme.bodySmall,
        ),
        trailing: const Icon(IconlyLight.arrowRight2, size: 18),
      ),
    );
  }
}
