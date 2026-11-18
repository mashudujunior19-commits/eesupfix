import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:ui/src/core/themes/towris_brand.dart';

/// Colours used only by the intro.
abstract final class IntroColors {
  static const wash = Color(0xFFEFF7F1);
  static const ringOuter = Color(0xFFE2F0E6);
  static const ringInner = Color(0xFFD3EADA);
  static const muted = Color(0xFF5E6A63);
  static const track = Color(0xFFDCE7DF);
  static const gold = Color(0xFFF4BE3A);
  static const goldDark = Color(0xFFD8951B);
}

enum IntroSceneKind { shop, pool, rewards }

/// The animated picture at the top of each intro page.
///
/// It loops gently while its page is the current one, and its pieces pop in
/// the first time the page is shown. With "reduce motion" on (and in tests)
/// it is drawn still.
class IntroScene extends StatefulWidget {
  const IntroScene({super.key, required this.kind, required this.active});

  final IntroSceneKind kind;
  final bool active;

  @override
  State<IntroScene> createState() => _IntroSceneState();
}

class _IntroSceneState extends State<IntroScene> with TickerProviderStateMixin {
  late final AnimationController _loop = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  );
  late final AnimationController _enter = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  );
  bool _still = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _still = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    _sync();
  }

  @override
  void didUpdateWidget(IntroScene oldWidget) {
    super.didUpdateWidget(oldWidget);
    _sync();
  }

  void _sync() {
    if (_still) {
      _loop.stop();
      _loop.value = .2;
      _enter.value = 1;
      return;
    }
    if (widget.active) {
      if (!_loop.isAnimating) _loop.repeat();
      if (_enter.value == 0 && !_enter.isAnimating) _enter.forward();
    } else {
      _loop.stop();
    }
  }

  @override
  void dispose() {
    _loop.dispose();
    _enter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final s = math.min(constraints.maxWidth, constraints.maxHeight);
        return Center(
          child: SizedBox.square(
            dimension: s,
            child: AnimatedBuilder(
              animation: Listenable.merge([_loop, _enter]),
              builder: (context, _) {
                final f = _Frame(s, _loop.value, _enter.value);
                return switch (widget.kind) {
                  IntroSceneKind.shop => _ShopScene(f),
                  IntroSceneKind.pool => _PoolScene(f),
                  IntroSceneKind.rewards => _RewardsScene(f),
                };
              },
            ),
          ),
        );
      },
    );
  }
}

/// One frame of a scene: its size, the loop time and the entry progress.
class _Frame {
  const _Frame(this.s, this.t, this.e);

  final double s;

  /// Loop time, 0 -> 1 every six seconds.
  final double t;

  /// Entry progress, 0 -> 1 once.
  final double e;

  /// A smooth wave in -1..1, [cycles] times per loop.
  double wave(double phase, {int cycles = 1}) =>
      math.sin(2 * math.pi * (t * cycles + phase));

  /// Entry progress of a piece that starts at [start] (0..1 of the entry).
  double enter(double start, {double length = .45}) =>
      ((e - start) / length).clamp(0.0, 1.0);

  /// Pop-in scale with a little overshoot.
  double pop(double start) => Curves.easeOutBack.transform(enter(start));

  /// Places [child] with its centre at ([dx], [dy]) * size from the middle.
  Widget at(double dx, double dy, Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.topLeft,
          child: FractionalTranslation(
            translation: const Offset(-.5, -.5),
            child: Transform.translate(
              offset: Offset(s / 2 + dx * s, s / 2 + dy * s),
              child: child,
            ),
          ),
        ),
      );
}

// ---------------------------------------------------------------------------
// Slide 1: catalog products floating around a basket.

class _Product {
  const _Product(
      this.file, this.dx, this.dy, this.height, this.tilt, this.phase,
      {this.boxed = false});

  final String file;
  final double dx;
  final double dy;
  final double height;
  final double tilt;
  final double phase;

  /// The photo has its own background, so it is shown as a rounded card.
  final bool boxed;
}

const _products = [
  _Product('rice', -.32, -.27, .30, -.12, 0),
  _Product('chips', .31, -.26, .29, .13, .35),
  _Product('noodles', -.29, .30, .20, .07, .6),
  _Product('soup', .31, .29, .27, -.09, .15),
  _Product('tea', 0, -.42, .13, .03, .8, boxed: true),
];

class _ShopScene extends StatelessWidget {
  const _ShopScene(this.f);

  final _Frame f;

  @override
  Widget build(BuildContext context) {
    final s = f.s;
    final basketIn = f.pop(0);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        f.at(0, 0, _Disc(s * .92, IntroColors.ringOuter)),
        f.at(0, 0, _Disc(s * .64, IntroColors.ringInner)),
        f.at(
          0,
          f.wave(0) * .012,
          Transform.rotate(
            angle: f.wave(.25) * .04,
            child: Transform.scale(
              scale: basketIn,
              child: _IconDisc(
                size: s * .40,
                icon: BootstrapIcons.basket3_fill,
                iconSize: s * .17,
              ),
            ),
          ),
        ),
        for (var i = 0; i < _products.length; i++)
          _floating(_products[i], .15 + i * .1),
      ],
    );
  }

  Widget _floating(_Product p, double start) {
    final s = f.s;
    final shown = f.enter(start);
    return f.at(
      p.dx,
      p.dy + f.wave(p.phase) * .022,
      Opacity(
        opacity: shown,
        child: Transform.scale(
          scale: .6 + .4 * f.pop(start),
          child: Transform.rotate(
            angle: p.tilt + f.wave(p.phase + .3) * .045,
            child: _ProductPhoto(p, s * p.height),
          ),
        ),
      ),
    );
  }
}

class _ProductPhoto extends StatelessWidget {
  const _ProductPhoto(this.product, this.height);

  final _Product product;
  final double height;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      'assets/images/intro/product_${product.file}.png',
      height: height,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.medium,
      errorBuilder: (_, __, ___) => SizedBox(height: height),
    );

    if (product.boxed) {
      return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color(0x2A0F3D22),
              blurRadius: 18,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: image,
        ),
      );
    }

    // A soft shadow cast by the packet's own shape.
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Transform.translate(
          offset: Offset(0, height * .07),
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Color(0x330F3D22),
                BlendMode.srcIn,
              ),
              child: image,
            ),
          ),
        ),
        image,
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Slide 2: neighbours' orders travelling into one KasiPool.

const _homeAngles = [-90.0, -18.0, 54.0, 126.0, 198.0];
const _homeRadius = .36;

class _PoolScene extends StatelessWidget {
  const _PoolScene(this.f);

  final _Frame f;

  @override
  Widget build(BuildContext context) {
    final s = f.s;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        f.at(0, 0, _Disc(s * .92, IntroColors.ringOuter)),
        Positioned.fill(
          child: CustomPaint(painter: _PoolPainter(f)),
        ),
        f.at(
          0,
          0,
          Transform.scale(
            scale: f.pop(0) * (1 + f.wave(0, cycles: 2) * .025),
            child: _IconDisc(
              size: s * .30,
              icon: BootstrapIcons.people_fill,
              iconSize: s * .12,
            ),
          ),
        ),
        for (var i = 0; i < _homeAngles.length; i++) _home(i),
      ],
    );
  }

  Widget _home(int i) {
    final s = f.s;
    final a = _homeAngles[i] * math.pi / 180;
    final start = .2 + i * .1;
    return f.at(
      math.cos(a) * _homeRadius,
      math.sin(a) * _homeRadius + f.wave(i * .2) * .008,
      Opacity(
        opacity: f.enter(start),
        child: Transform.scale(
          scale: f.pop(start),
          child: Container(
            width: s * .15,
            height: s * .15,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(s * .045),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1F0F3D22),
                  blurRadius: 16,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Icon(
              i.isEven
                  ? BootstrapIcons.house_heart_fill
                  : BootstrapIcons.house_door_fill,
              size: s * .065,
              color: i.isEven ? TowrisBrand.green : TowrisBrand.deepGreen,
            ),
          ),
        ),
      ),
    );
  }
}

class _PoolPainter extends CustomPainter {
  _PoolPainter(this.f);

  final _Frame f;

  @override
  void paint(Canvas canvas, Size size) {
    final s = f.s;
    final centre = Offset(s / 2, s / 2);

    // Pulse rings around the pool.
    for (final phase in [0.0, .5]) {
      final p = (f.t * 2 + phase) % 1;
      canvas.drawCircle(
        centre,
        s * (.15 + .2 * p),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = TowrisBrand.green.withOpacity(.35 * (1 - p) * f.e),
      );
    }

    for (var i = 0; i < _homeAngles.length; i++) {
      final shown = f.enter(.2 + i * .1);
      if (shown == 0) continue;
      final a = _homeAngles[i] * math.pi / 180;
      final dir = Offset(math.cos(a), math.sin(a));
      final from = centre + dir * (s * (_homeRadius - .085));
      final to = centre + dir * (s * .16);

      // Dotted path from the home to the pool.
      final dots = Paint()..color = TowrisBrand.green.withOpacity(.3 * shown);
      const steps = 7;
      for (var k = 0; k <= steps; k++) {
        canvas.drawCircle(Offset.lerp(from, to, k / steps)!, 2, dots);
      }

      // An order parcel travelling along it.
      final q = Curves.easeInOut.transform((f.t * 1.5 + i * .21) % 1);
      final fade = (q < .15
              ? q / .15
              : q > .85
                  ? (1 - q) / .15
                  : 1.0) *
          shown;
      final at = Offset.lerp(from, to, q)!;
      final box = RRect.fromRectAndRadius(
        Rect.fromCenter(center: at, width: s * .045, height: s * .045),
        Radius.circular(s * .01),
      );
      canvas.drawRRect(
        box.shift(const Offset(0, 2)),
        Paint()
          ..color = Colors.black.withOpacity(.12 * fade)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
      );
      canvas.drawRRect(
        box,
        Paint()..color = IntroColors.gold.withOpacity(fade),
      );
      canvas.drawLine(
        Offset(at.dx, box.top),
        Offset(at.dx, box.bottom),
        Paint()
          ..color = IntroColors.goldDark.withOpacity(fade)
          ..strokeWidth = 1.5,
      );
    }
  }

  @override
  bool shouldRepaint(_PoolPainter old) => old.f.t != f.t || old.f.e != f.e;
}

// ---------------------------------------------------------------------------
// Slide 3: coins rising out of a gift.

const _coinX = [-.2, .17, -.07, .25, -.27, .06, .12];
const _sparkles = [
  (-.36, -.28, 0.0),
  (.37, -.18, .3),
  (-.30, .33, .55),
  (.34, .30, .8),
];

class _RewardsScene extends StatelessWidget {
  const _RewardsScene(this.f);

  final _Frame f;

  @override
  Widget build(BuildContext context) {
    final s = f.s;
    final bounce = f.wave(0, cycles: 2).abs();
    return Stack(
      clipBehavior: Clip.none,
      children: [
        f.at(0, 0, _Disc(s * .92, IntroColors.ringOuter)),
        f.at(0, 0, _Disc(s * .64, IntroColors.ringInner)),
        for (final (dx, dy, phase) in _sparkles) f.at(dx, dy, _sparkle(phase)),
        for (var i = 0; i < _coinX.length; i++) _coin(i),
        f.at(
          0,
          .06 - bounce * .02,
          Transform.scale(
            scale: f.pop(0) * (1 + bounce * .02),
            child: _IconDisc(
              size: s * .36,
              icon: BootstrapIcons.gift_fill,
              iconSize: s * .15,
            ),
          ),
        ),
      ],
    );
  }

  Widget _coin(int i) {
    final s = f.s;
    final p = (f.t * 1.2 + i / _coinX.length) % 1;
    final fade = (p < .12
            ? p / .12
            : p > .7
                ? (1 - p) / .3
                : 1.0) *
        f.enter(.3);
    final size = s * (.075 + (i % 3) * .012);
    return f.at(
      _coinX[i] + math.sin(p * math.pi * 2 + i) * .02,
      .02 - .5 * p,
      Opacity(
        opacity: fade.clamp(0.0, 1.0),
        child: Transform.rotate(
          angle: math.sin(p * math.pi * 3 + i) * .3,
          child: _Coin(size),
        ),
      ),
    );
  }

  Widget _sparkle(double phase) {
    final s = f.s;
    final v = (f.wave(phase, cycles: 2) + 1) / 2;
    return Opacity(
      opacity: (.25 + .75 * v) * f.enter(.4),
      child: Transform.scale(
        scale: .7 + .3 * v,
        child: Icon(
          BootstrapIcons.stars,
          size: s * .07,
          color: IntroColors.goldDark,
        ),
      ),
    );
  }
}

class _Coin extends StatelessWidget {
  const _Coin(this.size);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFD866), IntroColors.gold, IntroColors.goldDark],
        ),
        border: Border.all(color: const Color(0xFFFFE9A6), width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33A86A00),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        'R',
        style: TextStyle(
          fontSize: size * .48,
          height: 1,
          fontWeight: FontWeight.w900,
          color: const Color(0xFF8A5A00),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared pieces.

class _Disc extends StatelessWidget {
  const _Disc(this.size, this.color);

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

class _IconDisc extends StatelessWidget {
  const _IconDisc({
    required this.size,
    required this.icon,
    required this.iconSize,
  });

  final double size;
  final IconData icon;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x260F3D22),
            blurRadius: 30,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: Icon(icon, size: iconSize, color: TowrisBrand.green),
    );
  }
}
