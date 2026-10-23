import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/order_confirmation/data_source/order_confirmation_data_source.dart';
import 'package:data/order_confirmation/models/order_confirmation.dart';
import 'package:data/order_confirmation/repository/order_confirmation_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/core/widgets/safe_network_image.dart';
import 'package:ui/src/views/order_confirmation/cubit/confirm_order_cubit.dart';

/// Lets a member confirm what they received from their KasiPool delivery.
/// Open it with `Navigator.of(context).push(ConfirmOrderScreen.route(id))`.
class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({super.key, required this.orderId});

  final int orderId;

  static Route<bool> route(int orderId) => MaterialPageRoute<bool>(
        builder: (_) => ConfirmOrderScreen(orderId: orderId),
      );

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => OrderConfirmationRepository(
        context.read<AuthRepository>(),
        OrderConfirmationDataSource(GetIt.I.get<SupabaseClient>()),
      ),
      child: Builder(
        builder: (context) => BlocProvider(
          create: (context) => ConfirmOrderCubit(
            context.read<OrderConfirmationRepository>(),
            orderId,
          )..load(),
          child: const _ConfirmOrderView(),
        ),
      ),
    );
  }
}

class _ConfirmOrderView extends StatelessWidget {
  const _ConfirmOrderView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Confirm my order'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: context.bgImage,
        child: BlocConsumer<ConfirmOrderCubit, ConfirmOrderState>(
          listenWhen: (_, s) => s is ConfirmOrderEditing && s.message != null,
          listener: (context, s) =>
              context.snackBarError((s as ConfirmOrderEditing).message!),
          builder: (context, state) {
            return switch (state) {
              ConfirmOrderLoading() => const FullScreenLoadingShimmer(),
              ConfirmOrderError(:final exception) =>
                FullScreenError(exception: exception),
              ConfirmOrderReadOnly(:final confirmation) =>
                _ReadOnlyView(confirmation: confirmation),
              ConfirmOrderEditing() => _EditingView(state: state),
              ConfirmOrderDone() => _DoneView(state: state),
            };
          },
        ),
      ),
    );
  }
}

Widget _card(BuildContext context, Widget child) => Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(top: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(padding: const EdgeInsets.all(12), child: child),
    );

String _lineSubtitle(ConfirmationLine l) => [
      if (l.brand != null && l.brand!.trim().isNotEmpty) l.brand!,
      if (l.size != null && l.size!.trim().isNotEmpty) l.size!,
    ].join('  ·  ');

class _ReadOnlyView extends StatelessWidget {
  const _ReadOnlyView({required this.confirmation});
  final OrderConfirmation confirmation;

  String _remedyText(ConfirmationLine l) {
    final received = l.receivedQty ?? l.orderedQty;
    if (received >= l.orderedQty) return 'Received $received of ${l.orderedQty}';
    final base = 'Received $received of ${l.orderedQty}';
    switch (l.remedy) {
      case ConfirmationRemedy.refund:
        return '$base · refund requested';
      case ConfirmationRemedy.backorder:
        final when = l.backorderWhen == BackorderWhen.nextRoute
            ? 'next route delivery'
            : 'your next order';
        return '$base · similar product on backorder ($when)';
      case null:
        return base;
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = confirmation;
    return ListView(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 40),
      children: [
        _card(
          context,
          Row(
            children: [
              Icon(
                c.isConfirmed ? Icons.check_circle : Icons.info_outline,
                color: c.isConfirmed
                    ? Colors.green
                    : context.colorScheme.primary,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  c.isConfirmed
                      ? 'You have already confirmed this order.'
                      : (c.reason ??
                          'This order cannot be confirmed right now.'),
                  style: context.textTheme.labelMedium,
                ),
              ),
            ],
          ),
        ),
        if (c.isConfirmed)
          for (final l in c.lines)
            _card(
              context,
              Row(
                children: [
                  SafeNetworkImage(l.imageUrl,
                      width: 44,
                      height: 44,
                      borderRadius: BorderRadius.circular(8)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l.name, style: context.textTheme.labelMedium),
                        Text(_remedyText(l), style: context.textTheme.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      ],
    );
  }
}

class _EditingView extends StatelessWidget {
  const _EditingView({required this.state});
  final ConfirmOrderEditing state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ConfirmOrderCubit>();
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
            children: [
              Text(
                'Check what arrived. Change the quantity for anything that '
                'was missing or damaged.',
                style: context.textTheme.bodySmall,
              ),
              for (final e in state.entries)
                _LineCard(
                  entry: e,
                  enabled: !state.submitting,
                  cubit: cubit,
                ),
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 6, 15, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!state.isValid)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      state.firstProblem!,
                      style: context.textTheme.bodySmall
                          ?.copyWith(color: context.colorScheme.error),
                    ),
                  ),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: state.isValid && !state.submitting
                        ? () => _confirmDialog(context, cubit)
                        : null,
                    child: state.submitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Confirm'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _confirmDialog(
      BuildContext context, ConfirmOrderCubit cubit) async {
    final parts = <String>[];
    if (state.refundCount > 0) parts.add('${state.refundCount} will be refunded');
    if (state.backorderCount > 0) {
      parts.add('${state.backorderCount} will be put on backorder');
    }
    final content = StringBuffer(
      'You received ${state.receivedTotal} of ${state.orderedTotal} items.',
    );
    if (parts.isNotEmpty) content.write(' ${parts.join(' and ')}.');
    content.write(' This cannot be undone.');

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm what you received?'),
        content: Text(content.toString()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Go back'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
    if (ok == true) cubit.submit();
  }
}

class _LineCard extends StatelessWidget {
  const _LineCard({
    required this.entry,
    required this.enabled,
    required this.cubit,
  });

  final LineEntry entry;
  final bool enabled;
  final ConfirmOrderCubit cubit;

  Future<void> _pickPhoto(BuildContext context) async {
    try {
      final res = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );
      final f = res?.files.single;
      if (f?.bytes != null) {
        cubit.setPhoto(entry.line.productId, f!.bytes!, f.extension ?? 'jpg');
      }
    } catch (_) {
      if (context.mounted) {
        context.snackBarError('Could not open your photos. You can skip this.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = entry.line;
    final id = l.productId;
    return _card(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SafeNetworkImage(l.imageUrl,
                  width: 52,
                  height: 52,
                  borderRadius: BorderRadius.circular(8)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l.name, style: context.textTheme.labelMedium),
                    if (_lineSubtitle(l).isNotEmpty)
                      Text(_lineSubtitle(l), style: context.textTheme.bodySmall),
                    Text('Ordered: ${l.orderedQty}',
                        style: context.textTheme.bodySmall),
                  ],
                ),
              ),
              IconButton.outlined(
                tooltip: 'Fewer',
                onPressed: enabled && entry.receivedQty > 0
                    ? () => cubit.setReceived(id, entry.receivedQty - 1)
                    : null,
                icon: const Icon(Icons.remove),
              ),
              SizedBox(
                width: 34,
                child: Center(
                  child: Text('${entry.receivedQty}',
                      style: context.textTheme.labelMedium),
                ),
              ),
              IconButton.outlined(
                tooltip: 'More',
                onPressed: enabled && entry.receivedQty < l.orderedQty
                    ? () => cubit.setReceived(id, entry.receivedQty + 1)
                    : null,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          if (entry.isShort) ...[
            const SizedBox(height: 10),
            Text(
              '${entry.shortBy} not received. What would you like us to do?',
              style: context.textTheme.bodySmall,
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              child: SegmentedButton<ConfirmationRemedy>(
                emptySelectionAllowed: true,
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(
                      value: ConfirmationRemedy.refund, label: Text('Refund')),
                  ButtonSegment(
                    value: ConfirmationRemedy.backorder,
                    label: Text('Similar product on backorder',
                        textAlign: TextAlign.center),
                  ),
                ],
                selected: {if (entry.remedy != null) entry.remedy!},
                onSelectionChanged: enabled
                    ? (s) {
                        if (s.isNotEmpty) cubit.setRemedy(id, s.first);
                      }
                    : null,
              ),
            ),
            if (entry.remedy == ConfirmationRemedy.backorder) ...[
              const SizedBox(height: 8),
              Text('When should it arrive?',
                  style: context.textTheme.bodySmall),
              const SizedBox(height: 6),
              SizedBox(
                width: double.infinity,
                child: SegmentedButton<BackorderWhen>(
                  emptySelectionAllowed: true,
                  showSelectedIcon: false,
                  segments: const [
                    ButtonSegment(
                        value: BackorderWhen.nextRoute,
                        label: Text('Next route delivery',
                            textAlign: TextAlign.center)),
                    ButtonSegment(
                        value: BackorderWhen.nextOrder,
                        label: Text('My next order',
                            textAlign: TextAlign.center)),
                  ],
                  selected: {
                    if (entry.backorderWhen != null) entry.backorderWhen!
                  },
                  onSelectionChanged: enabled
                      ? (s) {
                          if (s.isNotEmpty) cubit.setBackorderWhen(id, s.first);
                        }
                      : null,
                ),
              ),
            ],
            const SizedBox(height: 6),
            Row(
              children: [
                TextButton.icon(
                  onPressed: enabled ? () => _pickPhoto(context) : null,
                  icon: const Icon(Icons.photo_camera_outlined, size: 18),
                  label: Text(entry.photoBytes == null
                      ? 'Add a photo (optional)'
                      : 'Change photo'),
                ),
                if (entry.photoBytes != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.memory(entry.photoBytes!,
                        width: 36, height: 36, fit: BoxFit.cover),
                  ),
                  IconButton(
                    tooltip: 'Remove photo',
                    onPressed: enabled ? () => cubit.clearPhoto(id) : null,
                    icon: const Icon(Icons.close, size: 18),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _DoneView extends StatelessWidget {
  const _DoneView({required this.state});
  final ConfirmOrderDone state;

  @override
  Widget build(BuildContext context) {
    final r = state.result;
    final short = r.orderedTotal - r.receivedTotal;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 64),
            const SizedBox(height: 12),
            Text(
              state.alreadyConfirmed
                  ? 'This order was already confirmed'
                  : 'Thank you, your order is confirmed',
              textAlign: TextAlign.center,
              style: context.textTheme.labelMedium?.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              r.orderedTotal > 0
                  ? 'You received ${r.receivedTotal} of ${r.orderedTotal} items.'
                      '${short > 0 ? ' We will sort out the rest with you.' : ''}'
                  : 'We have recorded what you received.',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium,
            ),
            if (state.photoSkipped) ...[
              const SizedBox(height: 8),
              Text(
                'One of your photos could not be uploaded, but your '
                'confirmation was saved.',
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall,
              ),
            ],
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
