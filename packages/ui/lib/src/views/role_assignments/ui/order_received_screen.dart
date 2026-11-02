import 'package:data/role_assignments/models/order_receipt.dart';
import 'package:data/role_assignments/repository/role_assignments_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/utils/date_formatter.dart';
import 'package:ui/src/core/widgets/safe_network_image.dart';

/// The state of the "Order Received" checklist.
class ReceiptViewState {
  const ReceiptViewState({
    this.loading = true,
    this.busy = false,
    this.error,
    this.items = const [],
    this.ticked = const {},
    this.info,
  });

  final bool loading;

  /// Saving / uploading: the screen is locked.
  final bool busy;
  final String? error;
  final List<ReceiptItem> items;

  /// Products the receiver has checked off as dealt with.
  final Set<int> ticked;

  /// Set once the receipt is confirmed: the expected date and the order PIN.
  final DeliveryInfo? info;

  bool get isDone => info != null;
  bool get allTicked => items.isNotEmpty && ticked.length == items.length;

  ReceiptViewState copyWith({
    bool? loading,
    bool? busy,
    String? error,
    bool clearError = false,
    List<ReceiptItem>? items,
    Set<int>? ticked,
    DeliveryInfo? info,
  }) =>
      ReceiptViewState(
        loading: loading ?? this.loading,
        busy: busy ?? this.busy,
        error: clearError ? null : (error ?? this.error),
        items: items ?? this.items,
        ticked: ticked ?? this.ticked,
        info: info ?? this.info,
      );
}

class ReceiptCubit extends Cubit<ReceiptViewState> {
  ReceiptCubit(this._repo, this.eesupoolOrderId)
      : super(const ReceiptViewState());

  final RoleAssignmentsRepository _repo;
  final int eesupoolOrderId;

  Future<void> load() async {
    emit(const ReceiptViewState());
    final state = await _repo.fetchReceiptState(eesupoolOrderId);
    final receiptState = state.fold((l) {
      emit(ReceiptViewState(loading: false, error: l.message));
      return null;
    }, (r) => r);
    if (receiptState == null) return;

    // Already confirmed: straight to the date and PIN.
    if (receiptState.isConfirmed) {
      await _loadInfo();
      return;
    }
    if (!receiptState.isReceiver) {
      emit(const ReceiptViewState(
        loading: false,
        error: 'Only a bulk order receiver can confirm this order.',
      ));
      return;
    }
    if (!receiptState.isDispatched) {
      emit(const ReceiptViewState(
        loading: false,
        error: 'The warehouse has not dispatched this order yet. '
            'This screen opens once it has.',
      ));
      return;
    }
    final items = await _repo.fetchReceipt(eesupoolOrderId);
    items.fold(
      (l) => emit(ReceiptViewState(loading: false, error: l.message)),
      (r) => emit(ReceiptViewState(loading: false, items: r)),
    );
  }

  Future<void> _loadInfo() async {
    final res = await _repo.fetchDeliveryInfo(eesupoolOrderId);
    res.fold(
      (l) => emit(ReceiptViewState(loading: false, error: l.message)),
      (r) => emit(ReceiptViewState(loading: false, info: r)),
    );
  }

  void _replace(ReceiptItem item) => emit(state.copyWith(
        clearError: true,
        items: [
          for (final i in state.items) i.productId == item.productId ? item : i,
        ],
      ));

  /// Quantities can go down from what was ordered, and back up to it, but
  /// never above it.
  void changeQty(ReceiptItem item, int delta) {
    final next = (item.receivedQty + delta).clamp(0, item.orderedQty);
    if (next == item.receivedQty) return;
    _replace(item.copyWith(receivedQty: next));
  }

  void setFaulty(ReceiptItem item, bool faulty) => _replace(item.copyWith(
        isFaulty: faulty,
        faultComment: faulty ? item.faultComment : '',
        faultPhotoUrl: faulty ? item.faultPhotoUrl : '',
      ));

  void setComment(ReceiptItem item, String comment) =>
      _replace(item.copyWith(faultComment: comment));

  void setTicked(ReceiptItem item, bool ticked) {
    final set = {...state.ticked};
    ticked ? set.add(item.productId) : set.remove(item.productId);
    emit(state.copyWith(ticked: set, clearError: true));
  }

  Future<void> attachPhoto(ReceiptItem item) async {
    final picked = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: true);
    final file = picked?.files.single;
    if (file?.bytes == null) return;

    emit(state.copyWith(busy: true, clearError: true));
    final ext = (file!.extension ?? 'jpg').toLowerCase();
    final path = 'fault_reports/$eesupoolOrderId/'
        '${item.productId}_${DateTime.now().millisecondsSinceEpoch}.$ext';
    final res = await _repo.uploadFaultPhoto(path, file.bytes!);
    res.fold(
      (l) => emit(state.copyWith(busy: false, error: l.message)),
      (url) {
        emit(state.copyWith(busy: false));
        _replace(state.items
            .firstWhere((i) => i.productId == item.productId)
            .copyWith(faultPhotoUrl: url));
      },
    );
  }

  /// Validates, saves every line, confirms, then loads the delivery details.
  Future<void> confirm() async {
    if (!state.allTicked) {
      emit(state.copyWith(error: 'Check off every item first.'));
      return;
    }
    for (final i in state.items) {
      if (i.isFaulty && (i.faultComment ?? '').trim().isEmpty) {
        emit(state.copyWith(
            error: 'Add a comment for the faulty item "${i.name}".'));
        return;
      }
    }

    emit(state.copyWith(busy: true, clearError: true));
    for (final i in state.items) {
      final saved =
          await _repo.saveReceiptItem(eesupoolOrderId: eesupoolOrderId, item: i);
      final failure = saved.fold((l) => l.message, (_) => null);
      if (failure != null) {
        emit(state.copyWith(busy: false, error: failure));
        return;
      }
    }
    final confirmed = await _repo.confirmReceipt(eesupoolOrderId);
    final failure = confirmed.fold((l) => l.message, (_) => null);
    if (failure != null) {
      emit(state.copyWith(busy: false, error: failure));
      return;
    }
    await _loadInfo();
  }
}

/// "Order Received": the official checklist a bulk order receiver fills in
/// after the warehouse has dispatched the order. Quantities can only be
/// decreased; faulty items take a comment and an optional photo that go to
/// the warehouse. After confirming, the expected date and the order PIN show.
class OrderReceivedScreen extends StatelessWidget {
  const OrderReceivedScreen({super.key, required this.eesupoolOrderId});

  final int eesupoolOrderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReceiptCubit(
        context.read<RoleAssignmentsRepository>(),
        eesupoolOrderId,
      )..load(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Order Received')),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: context.bgImage,
          child: BlocConsumer<ReceiptCubit, ReceiptViewState>(
            listenWhen: (a, b) =>
                b.error != null && b.error != a.error && b.items.isNotEmpty,
            listener: (context, state) => context.snackBarError(state.error!),
            builder: (context, state) {
              if (state.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.isDone) return _DeliveryDetails(info: state.info!);
              if (state.items.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Text(
                      state.error ?? 'There is nothing to confirm on this order.',
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                );
              }
              return _Checklist(state: state);
            },
          ),
        ),
      ),
    );
  }
}

class _Checklist extends StatelessWidget {
  const _Checklist({required this.state});
  final ReceiptViewState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReceiptCubit>();
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 120),
          children: [
            Text(
              'Check every item against what arrived. You can lower a '
              'quantity if something is short, but never raise it. Flag '
              'faulty items so the warehouse can collect them.',
              style: context.textTheme.bodySmall,
            ),
            const SizedBox(height: 6),
            Text(
              '${state.ticked.length} of ${state.items.length} items checked',
              style: context.textTheme.labelMedium,
            ),
            for (final item in state.items)
              _ItemCard(
                item: item,
                ticked: state.ticked.contains(item.productId),
              ),
          ],
        ),
        Positioned(
          left: 15,
          right: 15,
          bottom: 15,
          child: SafeArea(
            child: FilledButton(
              onPressed: state.busy ? null : cubit.confirm,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: state.busy
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Confirm order received'),
            ),
          ),
        ),
      ],
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({required this.item, required this.ticked});
  final ReceiptItem item;
  final bool ticked;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReceiptCubit>();
    final short = item.receivedQty < item.orderedQty;
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(top: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: item.isFaulty ? Colors.red.shade200 : Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SafeNetworkImage(
                  item.imageUrl,
                  width: 44,
                  height: 44,
                  borderRadius: BorderRadius.circular(8),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name, style: context.textTheme.labelMedium),
                      Text(
                        [
                          'Ordered ${item.orderedQty}',
                          if (item.size != null && item.size!.trim().isNotEmpty)
                            item.size!,
                        ].join('  ·  '),
                        style: context.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Checkbox(
                  value: ticked,
                  onChanged: (v) => cubit.setTicked(item, v ?? false),
                ),
              ],
            ),
            Row(
              children: [
                Text('Received', style: context.textTheme.bodySmall),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: item.receivedQty > 0
                      ? () => cubit.changeQty(item, -1)
                      : null,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text(
                  '${item.receivedQty}',
                  style: context.textTheme.labelMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: short ? Colors.red.shade700 : Colors.black,
                  ),
                ),
                // Can only climb back to what was ordered, never above it.
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: item.receivedQty < item.orderedQty
                      ? () => cubit.changeQty(item, 1)
                      : null,
                  icon: const Icon(Icons.add_circle_outline),
                ),
                const Spacer(),
                Text('Faulty', style: context.textTheme.bodySmall),
                Switch(
                  value: item.isFaulty,
                  onChanged: (v) => cubit.setFaulty(item, v),
                ),
              ],
            ),
            if (item.isFaulty) ...[
              TextFormField(
                key: ValueKey('comment-${item.productId}'),
                initialValue: item.faultComment,
                minLines: 2,
                maxLines: 4,
                onChanged: (v) => cubit.setComment(item, v),
                decoration: const InputDecoration(
                  labelText: 'What is wrong with it? (sent to the warehouse)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () => cubit.attachPhoto(item),
                    icon: const Icon(Icons.photo_camera_outlined),
                    label: Text(
                      (item.faultPhotoUrl ?? '').isEmpty
                          ? 'Add a photo'
                          : 'Change photo',
                    ),
                  ),
                  const SizedBox(width: 10),
                  if ((item.faultPhotoUrl ?? '').isNotEmpty)
                    SafeNetworkImage(
                      item.faultPhotoUrl,
                      width: 44,
                      height: 44,
                      borderRadius: BorderRadius.circular(8),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Shown after the receipt is confirmed: the expected delivery date and the
/// order PIN, visible only to the KasiPool admin and the bulk receivers.
class _DeliveryDetails extends StatelessWidget {
  const _DeliveryDetails({required this.info});
  final DeliveryInfo info;

  @override
  Widget build(BuildContext context) {
    final date = info.expectedDate;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle,
                size: 64, color: context.colorScheme.primary),
            const SizedBox(height: 12),
            Text('Checklist saved', style: context.textTheme.titleMedium),
            const SizedBox(height: 24),
            Text('Expected delivery date', style: context.textTheme.bodySmall),
            const SizedBox(height: 4),
            Text(
              date == null
                  ? 'To be confirmed'
                  : DateFormatter.formatDateToNameday(date),
              style: context.textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            Text('Order PIN', style: context.textTheme.bodySmall),
            const SizedBox(height: 4),
            Text(
              info.pin?.toString() ?? '—',
              style: context.textTheme.displaySmall?.copyWith(
                letterSpacing: 6,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Only the KasiPool admin and the bulk receivers can see the '
              'date and PIN. Do not share the PIN.',
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
