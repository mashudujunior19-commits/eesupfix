import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/orders/repository/collection_pin_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';

CollectionPinRepository _repo(BuildContext context) => CollectionPinRepository(
      context.read<AuthRepository>(),
      GetIt.I.get<SupabaseClient>(),
    );

/// Shown to the customer on their KasiPool order: the secret collection PIN
/// once the order is packed, otherwise when to expect it. The PIN is fetched
/// from the server each time and is never stored in the app.
class MyCollectionPinCard extends StatefulWidget {
  const MyCollectionPinCard({
    super.key,
    required this.orderId,
    required this.refreshKey,
  });

  final int orderId;

  /// Changes whenever the order changes, so the card refetches.
  final Object refreshKey;

  @override
  State<MyCollectionPinCard> createState() => _MyCollectionPinCardState();
}

class _MyCollectionPinCardState extends State<MyCollectionPinCard> {
  CollectionPin? _pin;
  String? _error;
  bool _hidden = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant MyCollectionPinCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.refreshKey != widget.refreshKey) _load();
  }

  Future<void> _load() async {
    final res = await _repo(context).getMyPin(widget.orderId);
    if (!mounted) return;
    res.fold(
      (e) => setState(() => _error = e.message),
      (p) => setState(() {
        _pin = p;
        _error = null;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = _pin;
    if (p == null && _error == null) return const SizedBox.shrink();
    if (p != null &&
        (p.state == 'not_pool_order' || p.state == 'cancelled')) {
      return const SizedBox.shrink();
    }

    final ready = p?.isReady ?? false;
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ready
            ? context.colorScheme.primary.withOpacity(0.06)
            : Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ready ? context.colorScheme.primary : Colors.blueGrey.shade100,
          width: 0.8,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.pin_outlined,
                  size: 16, color: context.colorScheme.primary),
              6.sW,
              Text('Collection PIN', style: context.textTheme.labelMedium),
            ],
          ),
          8.sH,
          if (_error != null)
            Text(_error!, style: context.textTheme.bodySmall)
          else if (ready) ...[
            Row(
              children: [
                Text(
                  _hidden ? '• • • • • •' : p!.pin!,
                  style: context.textTheme.headlineSmall?.copyWith(
                    letterSpacing: 6,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => setState(() => _hidden = !_hidden),
                  icon: Icon(_hidden ? Icons.visibility : Icons.visibility_off,
                      size: 18),
                  label: Text(_hidden ? 'Show' : 'Hide'),
                ),
              ],
            ),
            Text(p!.message ?? '', style: context.textTheme.labelSmall),
          ] else
            Text(p?.message ?? '', style: context.textTheme.bodySmall),
        ],
      ),
    );
  }
}

/// The Dispatcher types the customer's PIN to confirm the handover. The check
/// is done by the server (attempts are limited there); pops `true` once the
/// order is marked collected.
class CollectionPinEntryDialog extends StatefulWidget {
  const CollectionPinEntryDialog({super.key, required this.orderId});

  final int orderId;

  @override
  State<CollectionPinEntryDialog> createState() =>
      _CollectionPinEntryDialogState();
}

class _CollectionPinEntryDialogState extends State<CollectionPinEntryDialog> {
  final _controller = TextEditingController();
  bool _busy = false;
  String? _message;
  bool _locked = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final pin = _controller.text.trim();
    if (pin.length != 6 || int.tryParse(pin) == null) {
      setState(() => _message = 'Enter the 6-digit PIN the customer gives you.');
      return;
    }
    setState(() {
      _busy = true;
      _message = null;
    });
    final res = await _repo(context).confirmCollection(widget.orderId, pin);
    if (!mounted) return;
    res.fold(
      (e) => setState(() {
        _busy = false;
        _message = e.message;
      }),
      (r) {
        if (r.ok) {
          context.snackBarSuccess(r.message);
          Navigator.pop(context, true);
        } else {
          setState(() {
            _busy = false;
            _message = r.message;
            _locked = r.locked;
            _controller.clear();
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Confirm Collection'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Ask the customer for their 6-digit collection PIN. It is shown '
              'only in their app. The order is marked collected once the PIN '
              'is correct.',
              style: context.textTheme.labelSmall?.copyWith(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            10.sH,
            EESUpTextFormField(
              hintText: 'Customer PIN',
              controller: _controller,
              type: TextInputType.number,
            ),
            if (_message != null) ...[
              8.sH,
              Text(
                _message!,
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall?.copyWith(color: Colors.red),
              ),
            ],
            20.sH,
            ElevatedButton(
              onPressed: _busy || _locked ? null : _submit,
              child: _busy
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Confirm handover'),
            ),
          ],
        ),
      ),
    );
  }
}
