import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/core/themes/towris_brand.dart';
import 'package:ui/src/core/widgets/safe_network_image.dart';

import 'hamper_widgets.dart';

/// One Home banner: the picture with its overlay images, the hamper name and
/// price, and what it saves. Tapping is handled by the carousel that holds it.
///
/// It needs no data calls of its own: the banner details already carry
/// everything shown here. Profit figures are no longer shown to customers.
class HamperImageStack extends StatelessWidget {
  final String? imgUrl;
  final String? hamperCode;
  final double? hamperPrice;
  final double? saving;
  final String? hamperGifUrl1;
  final String? hamperGifUrl2;

  const HamperImageStack({
    super.key,
    required this.imgUrl,
    this.hamperCode,
    this.hamperPrice,
    this.saving,
    this.hamperGifUrl1,
    this.hamperGifUrl2,
  });

  @override
  Widget build(BuildContext context) {
    final hasHamper = hamperCode != null && hamperPrice != null;
    return Semantics(
      button: true,
      label: hasHamper
          ? 'Hamper $hamperCode, ${hamperMoney(hamperPrice!)}'
          : 'Banner',
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: SafeNetworkImage(imgUrl, fit: BoxFit.contain),
          ),
          if (hamperGifUrl1 != null && hamperGifUrl1!.isNotEmpty)
            Positioned(
              top: 10,
              left: 10,
              child: Image.network(
                hamperGifUrl1!,
                height: 50,
                width: 100,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          if (hamperGifUrl2 != null && hamperGifUrl2!.isNotEmpty)
            Positioned(
              bottom: 0,
              right: 20,
              child: Image.network(
                hamperGifUrl2!,
                height: 75,
                width: 140,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          if (hasHamper)
            Positioned(
              top: 10,
              left: 10,
              child: Text(
                '$hamperCode ${hamperMoney(hamperPrice!)}',
                style: GoogleFonts.lemon(
                  fontSize: 22,
                  color: const Color(0xFFFF0000),
                ),
              ),
            ),
          if (saving != null && saving! > 0)
            Positioned(
              bottom: 10,
              left: 10,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: TowrisBrand.deepGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Save ${hamperMoney(saving!)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
