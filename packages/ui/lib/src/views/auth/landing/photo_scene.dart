import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// The photographic layers of the landing scene. Drop real photographs into
/// `app/assets/images/landing/` using these names and the scene uses them
/// instead of the vector fallback:
///
/// * `street.jpg`   - wide street of homes, no vehicle or people (portrait or
///                    landscape, at least 1600px on the long side)
/// * `truck.png`    - delivery truck loaded with groceries, side view,
///                    facing right, transparent background (>= 2400px wide)
/// * `person_1.png` .. `person_4.png` - full-length people on transparent
///                    backgrounds (>= 1200px tall)
class LandingPhotos {
  const LandingPhotos._(this.available, this.people);

  static const String _dir = 'assets/images/landing/';
  static const String background = '${_dir}street.jpg';
  static const String truck = '${_dir}truck.png';
  static const List<String> _people = [
    '${_dir}person_1.png',
    '${_dir}person_2.png',
    '${_dir}person_3.png',
    '${_dir}person_4.png',
  ];

  static const LandingPhotos none = LandingPhotos._(false, []);

  /// True when at least the street and the truck photographs are present.
  final bool available;
  final List<String> people;

  static Future<LandingPhotos> load() async {
    try {
      final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      final keys = manifest.listAssets().toSet();
      final ok = keys.contains(background) && keys.contains(truck);
      if (!ok) return none;
      return LandingPhotos._(true, [
        for (final p in _people)
          if (keys.contains(p)) p,
      ]);
    } catch (_) {
      return none;
    }
  }
}

double _ease(double t) =>
    t < .5 ? 4 * t * t * t : 1 - math.pow(-2 * t + 2, 3) / 2;

/// Photographic street scene: the truck drives across while neighbours stand
/// outside their homes and step toward it. [progress] runs 0 -> 1.
class PhotoScene extends StatelessWidget {
  const PhotoScene({super.key, required this.progress, required this.photos});

  final double progress;
  final LandingPhotos photos;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        final w = box.maxWidth;
        final h = box.maxHeight;
        final t = progress.clamp(0.0, 1.0);
        final drive = _ease(t);
        // Sized from the narrower side so it fits any phone or aspect ratio.
        final truckW = math.min(w * .92, h * .62);
        final truckX = -truckW * 1.05 + (w + truckW * 2.1) * drive;
        final truckCentre = truckX + truckW / 2;
        final groundY = h * .17;
        final personH = math.min(h * .3, w * .62);

        return Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned.fill(
              child: Image.asset(
                LandingPhotos.background,
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
                filterQuality: FilterQuality.high,
                isAntiAlias: true,
              ),
            ),
            // Keeps the title legible over any photograph.
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: h * .46,
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xB3000000), Color(0x00000000)],
                  ),
                ),
              ),
            ),
            for (var i = 0; i < photos.people.length; i++)
              _person(
                photos.people[i],
                i,
                photos.people.length,
                w,
                personH,
                groundY,
                truckCentre,
                t,
              ),
            Positioned(
              left: truckX,
              bottom: groundY * .55,
              width: truckW,
              child: Image.asset(
                LandingPhotos.truck,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
                isAntiAlias: true,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _person(
    String asset,
    int i,
    int count,
    double w,
    double personH,
    double groundY,
    double truckCentre,
    double t,
  ) {
    final baseX = w * (.08 + .84 * (i + .5) / count);
    final near = (1 - ((truckCentre - baseX).abs() / (w * .55))).clamp(0.0, 1.0);
    // People step toward the truck as it passes and sway a little.
    final step = (truckCentre - baseX).sign * near * w * .035;
    final bob = math.sin(t * 22 + i * 1.3) * 2.0;
    final pw = personH * .45;
    return Positioned(
      left: baseX - pw / 2 + step,
      bottom: groundY + (i.isOdd ? personH * .06 : 0) + bob,
      height: personH * (i.isOdd ? .94 : 1),
      child: Image.asset(
        asset,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
        isAntiAlias: true,
      ),
    );
  }
}
