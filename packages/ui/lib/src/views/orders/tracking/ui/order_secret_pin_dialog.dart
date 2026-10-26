import 'package:data/orders/models/order_product.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';

class OrderSecretPinDialog extends StatefulWidget {
  const OrderSecretPinDialog({
    super.key,
    required this.pin,
    required this.products,
  });

  final String pin;
  final List<OrderProduct> products;

  @override
  State<OrderSecretPinDialog> createState() => _OrderSecretPinDialogState();
}

class _OrderSecretPinDialogState extends State<OrderSecretPinDialog> {
  final Set<int> _checkedProductIds = {};
  bool _pinRevealed = false;

  bool get _allProductsChecked =>
      widget.products.isNotEmpty &&
      widget.products.every((p) => _checkedProductIds.contains(p.productId));

  void _toggleChecked(int productId, bool? checked) {
    setState(() {
      if (checked ?? false) {
        _checkedProductIds.add(productId);
      } else {
        _checkedProductIds.remove(productId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title: const Text('Confirm Order'),
      ),
      body: Container(
        decoration: context.bgImage,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            15.sH,
            Text(
              'By providing this PIN, you are confirming that you have '
              'reviewed the products and you are satisfied with the order.',
              textAlign: TextAlign.center,
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: 13.5,
              ),
            ),
            20.sH,
            for (final product in widget.products)
              CheckboxListTile(
                value: _checkedProductIds.contains(product.productId),
                onChanged: _pinRevealed
                    ? null
                    : (checked) => _toggleChecked(product.productId, checked),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(
                  '${product.name}${product.quantity > 1 ? ' x${product.quantity}' : ''}',
                  style: context.textTheme.labelMedium,
                ),
              ),
            20.sH,
            if (_pinRevealed)
              Text(
                'Secret Pin: ${widget.pin}',
                textAlign: TextAlign.center,
                style: context.textTheme.labelLarge?.copyWith(
                  fontSize: 15,
                  color: context.colorScheme.primary,
                ),
              ),
            90.sH,
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: _pinRevealed
              ? null
              : _allProductsChecked
                  ? () => setState(() => _pinRevealed = true)
                  : null,
          child: Text(_pinRevealed ? 'Pin shared' : 'Happy with these'),
        ),
      ),
    );
  }
}
