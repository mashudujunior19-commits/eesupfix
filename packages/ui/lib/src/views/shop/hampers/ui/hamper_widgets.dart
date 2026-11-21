import 'package:data/shopping/models/hamper_offer.dart';
import 'package:data/utils/double_ext.dart';
import 'package:flutter/material.dart';
import 'package:ui/src/core/themes/towris_brand.dart';
import 'package:ui/src/core/widgets/safe_network_image.dart';

/// "R120.50" - one place for how a hamper amount is written.
String hamperMoney(double amount) => 'R${amount.toRounded()}';

/// "Ends today", "Ends tomorrow", "Ends in 5 days", or null with no end date.
String? hamperEndsIn(HamperOffer hamper, [DateTime? now]) {
  final days = hamper.daysLeft(now);
  if (days == null) return null;
  if (days <= 0) return 'Ends today';
  if (days == 1) return 'Ends tomorrow';
  return 'Ends in $days days';
}

/// A small rounded label such as "Save R40".
class HamperChip extends StatelessWidget {
  const HamperChip(this.label, {super.key, this.highlight = false});
  final String label;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: highlight ? TowrisBrand.mint : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: highlight ? TowrisBrand.deepGreen : Colors.grey.shade800,
        ),
      ),
    );
  }
}

/// The hamper picture with its two small overlay images, if it has them.
class HamperPicture extends StatelessWidget {
  const HamperPicture({
    super.key,
    required this.imgUrl,
    this.gifUrl1,
    this.gifUrl2,
    this.height = 180,
    this.fit = BoxFit.contain,
    this.semanticLabel,
  });

  final String? imgUrl;
  final String? gifUrl1;
  final String? gifUrl2;
  final double height;
  final BoxFit fit;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      label: semanticLabel,
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: Stack(
          children: [
            Positioned.fill(
              child: SafeNetworkImage(imgUrl, fit: fit),
            ),
            if (gifUrl1 != null && gifUrl1!.isNotEmpty)
              Positioned(
                top: 10,
                left: 10,
                child: Image.network(
                  gifUrl1!,
                  height: 50,
                  width: 100,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                ),
              ),
            if (gifUrl2 != null && gifUrl2!.isNotEmpty)
              Positioned(
                bottom: 0,
                right: 20,
                child: Image.network(
                  gifUrl2!,
                  height: 75,
                  width: 140,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Shown when hampers could not be loaded: says so and lets the user retry.
class HamperRetry extends StatelessWidget {
  const HamperRetry({super.key, required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.grey),
            const SizedBox(height: 12),
            Text(
              message.isEmpty ? 'We could not load this hamper.' : message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}
