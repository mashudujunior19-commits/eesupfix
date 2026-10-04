import 'package:auto_route/auto_route.dart';
import 'package:data/role_assignments/repository/role_assignments_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/core/widgets/safe_network_image.dart';
import 'package:ui/src/views/role_assignments/cubit/role_checklist_cubit.dart';

/// What someone with a role on a KasiPool order (receiver, packer, ...)
/// sees: the items bought, as a checklist they can tick off. Prices are
/// never shown here (the data source doesn't return them).
@RoutePage()
class RoleChecklistScreen extends StatelessWidget {
  const RoleChecklistScreen({
    super.key,
    required this.eesupoolOrderId,
    this.orderId,
    this.title,
    this.role,
  });

  final int eesupoolOrderId;

  /// A member order's id, or null for the whole bulk order.
  final int? orderId;
  final String? title;
  final String? role;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoleChecklistCubit(
        context.read<RoleAssignmentsRepository>(),
        eesupoolOrderId,
        orderId,
      )..load(),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text(title ?? 'Checklist'),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: context.bgImage,
          child: BlocConsumer<RoleChecklistCubit, RoleChecklistState>(
            listenWhen: (_, state) =>
                state is RoleChecklistLoaded && state.saveError != null,
            listener: (context, state) {
              context.snackBarError((state as RoleChecklistLoaded).saveError!);
            },
            builder: (context, state) {
              return switch (state) {
                RoleChecklistLoading() => const FullScreenLoadingShimmer(),
                RoleChecklistError(:final exception) =>
                  FullScreenError(exception: exception),
                RoleChecklistLoaded(:final items) when items.isEmpty =>
                  FullScreenError(
                    isError: false,
                    exception: EESUpException(
                      message: 'No items have been bought on this order yet.',
                    ),
                  ),
                RoleChecklistLoaded() => RefreshIndicator(
                    onRefresh: context.read<RoleChecklistCubit>().load,
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 40),
                      children: [
                        _Header(
                          role: role,
                          checked: state.checkedCount,
                          total: state.items.length,
                        ),
                        for (final item in state.items)
                          Card(
                            color: Colors.white,
                            elevation: 0,
                            margin: const EdgeInsets.only(top: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.grey.shade200),
                            ),
                            child: CheckboxListTile(
                              value: item.isChecked,
                              onChanged: (_) => context
                                  .read<RoleChecklistCubit>()
                                  .toggle(item),
                              secondary: SafeNetworkImage(
                                item.imageUrl,
                                width: 44,
                                height: 44,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              title: Text(
                                item.name,
                                style: context.textTheme.labelMedium?.copyWith(
                                  decoration: item.isChecked
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                              subtitle: Text(
                                [
                                  'Qty ${item.quantity}',
                                  if (item.size != null &&
                                      item.size!.trim().isNotEmpty)
                                    item.size!,
                                ].join('  ·  '),
                                style: context.textTheme.bodySmall,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
              };
            },
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.role,
    required this.checked,
    required this.total,
  });

  final String? role;
  final int checked;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (role != null)
            Text(
              'Your role: $role',
              style: context.textTheme.labelMedium?.copyWith(fontSize: 15),
            ),
          const SizedBox(height: 6),
          Text(
            '$checked of $total items checked',
            style: context.textTheme.bodySmall,
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: total == 0 ? 0 : checked / total,
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
        ],
      ),
    );
  }
}
