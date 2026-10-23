import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Brand colours used by the landing sequence and the sign-in header.
abstract final class TowrisBrand {
  static const Color deepGreen = Color(0xFF14532D);
  static const Color green = Color(0xFF2E8B57);
  static const Color lightGreen = Color(0xFF8CC63F);
  static const Color mint = Color(0xFFE6F5EA);
  static const String name = 'Towris';
  static const String slogan = 'Own your economy.';
}

/// A flat-vector scene of a Towris delivery van carrying groceries past a row
/// of homes while neighbours wave. [progress] runs 0 -> 1: the van enters from
/// the left and leaves on the right.
class VanScene extends StatelessWidget {
  const VanScene({super.key, required this.progress, this.showPeople = true});

  final double progress;
  final bool showPeople;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _VanScenePainter(progress, showPeople),
      size: Size.infinite,
    );
  }
}

/// Just the van, for use in a header illustration. [wheelTurn] spins wheels.
class VanIllustration extends StatelessWidget {
  const VanIllustration({super.key, this.wheelTurn = 0});

  final double wheelTurn;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _VanOnlyPainter(wheelTurn),
      size: Size.infinite,
    );
  }
}

class _VanOnlyPainter extends CustomPainter {
  _VanOnlyPainter(this.wheelTurn);
  final double wheelTurn;

  @override
  void paint(Canvas canvas, Size size) {
    final vanWidth = size.width;
    _drawVan(canvas, Offset(0, size.height * 0.92), vanWidth, wheelTurn);
  }

  @override
  bool shouldRepaint(_VanOnlyPainter old) => old.wheelTurn != wheelTurn;
}

double _easeInOut(double t) => t < .5 ? 2 * t * t : 1 - math.pow(-2 * t + 2, 2) / 2;

class _VanScenePainter extends CustomPainter {
  _VanScenePainter(this.t, this.showPeople);

  final double t;
  final bool showPeople;

  static const _skin = [
    Color(0xFF8D5524),
    Color(0xFFC68642),
    Color(0xFFE0AC69),
    Color(0xFF5C3A21),
  ];
  static const _shirts = [
    Color(0xFFF59E0B),
    Color(0xFF3B82F6),
    Color(0xFFEF4444),
    Color(0xFF8B5CF6),
    Color(0xFF14B8A6),
    Color(0xFFEC4899),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Sky.
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFDDF3E4), Color(0xFFF7FCF8)],
        ).createShader(Offset.zero & size),
    );
    canvas.drawCircle(
      Offset(w * .82, h * .12),
      w * .16,
      Paint()..color = const Color(0xFFFFF3C4).withOpacity(.75),
    );

    final roadTop = h * .80;
    final sidewalkTop = h * .74;

    // Distant skyline, drifting slowly for depth.
    final drift = -t * w * .06;
    final skyline = Paint()..color = const Color(0xFFCFE8D6);
    const widths = [.12, .09, .15, .1, .13, .11, .14, .1];
    const heights = [.13, .19, .11, .22, .15, .18, .12, .2];
    var x = -w * .05 + drift;
    for (var i = 0; i < widths.length; i++) {
      final bw = w * widths[i];
      final bh = h * heights[i] * .8;
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(x, sidewalkTop - h * .12 - bh, bw, bh),
          topLeft: const Radius.circular(6),
          topRight: const Radius.circular(6),
        ),
        skyline,
      );
      x += bw + w * .015;
    }

    // Homes.
    const homeColors = [
      Color(0xFFFFFFFF),
      Color(0xFFFFF6E5),
      Color(0xFFF1F8F3),
    ];
    const roofColors = [
      Color(0xFF2E8B57),
      Color(0xFF14532D),
      Color(0xFF3F9E6B),
    ];
    final homeW = w * .27;
    final homeH = h * .17;
    final homeBase = sidewalkTop - h * .005;
    final homeXs = [w * .03, w * .365, w * .70];
    for (var i = 0; i < 3; i++) {
      _drawHome(
        canvas,
        Rect.fromLTWH(homeXs[i], homeBase - homeH, homeW, homeH),
        homeColors[i],
        roofColors[i],
      );
    }

    // Sidewalk and road.
    canvas.drawRect(
      Rect.fromLTRB(0, sidewalkTop, w, roadTop),
      Paint()..color = const Color(0xFFE4E7E4),
    );
    canvas.drawRect(
      Rect.fromLTRB(0, sidewalkTop, w, sidewalkTop + 3),
      Paint()..color = const Color(0xFFCBD0CB),
    );
    canvas.drawRect(
      Rect.fromLTRB(0, roadTop, w, h),
      Paint()..color = const Color(0xFF3A4440),
    );
    // Moving dashed lane marking.
    final dash = Paint()
      ..color = Colors.white.withOpacity(.55)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    final laneY = roadTop + (h - roadTop) * .5;
    final dashShift = (t * w * 2.2) % (w * .12);
    for (var dx = -w * .12 + dashShift; dx < w; dx += w * .12) {
      canvas.drawLine(Offset(dx, laneY), Offset(dx + w * .06, laneY), dash);
    }

    // Van position: eased drive from off-screen left to off-screen right.
    final vanW = w * .56;
    final drive = _easeInOut(t.clamp(0.0, 1.0));
    final vanX = -vanW * 1.05 + (w + vanW * 2.1) * drive;
    final vanBaseY = roadTop + (h - roadTop) * .42;

    // Neighbours wave harder as the van comes close.
    if (showPeople) {
      const personXs = [.14, .26, .44, .58, .78, .9];
      for (var i = 0; i < personXs.length; i++) {
        final px = w * personXs[i];
        final vanCentre = vanX + vanW * .5;
        final near = (1 - ((vanCentre - px).abs() / (w * .55))).clamp(0.0, 1.0);
        final wave = math.sin(t * 38 + i * 1.7) * (.25 + .5 * near);
        // People lean toward the van as it passes.
        final lean = (vanCentre - px).sign * near * w * .012;
        _drawPerson(
          canvas,
          Offset(px + lean, sidewalkTop + (roadTop - sidewalkTop) * .78),
          w * .0042 * (1 + (i % 2) * .08),
          _skin[i % _skin.length],
          _shirts[i % _shirts.length],
          wave,
          waving: t < .92,
          facingRight: vanCentre > px,
        );
      }
    }

    // Van with a soft ground shadow.
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(vanX + vanW * .5, vanBaseY + 4),
        width: vanW * .92,
        height: 12,
      ),
      Paint()..color = Colors.black.withOpacity(.22),
    );
    _drawVan(canvas, Offset(vanX, vanBaseY), vanW, vanX / (w * .09));
  }

  @override
  bool shouldRepaint(_VanScenePainter old) =>
      old.t != t || old.showPeople != showPeople;

  void _drawHome(Canvas canvas, Rect r, Color wall, Color roof) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(r.shift(const Offset(0, 3)), const Radius.circular(4)),
      Paint()..color = Colors.black.withOpacity(.06),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(r, const Radius.circular(4)),
      Paint()..color = wall,
    );
    final roofPath = Path()
      ..moveTo(r.left - r.width * .05, r.top + 2)
      ..lineTo(r.center.dx, r.top - r.height * .42)
      ..lineTo(r.right + r.width * .05, r.top + 2)
      ..close();
    canvas.drawPath(roofPath, Paint()..color = roof);
    // Door.
    final door = Rect.fromCenter(
      center: Offset(r.center.dx, r.bottom - r.height * .3),
      width: r.width * .2,
      height: r.height * .6,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(door, const Radius.circular(3)),
      Paint()..color = const Color(0xFF5B3A29),
    );
    // Windows.
    final win = Paint()..color = const Color(0xFFBFE3F5);
    for (final fx in [.12, .68]) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(r.left + r.width * fx, r.top + r.height * .22,
              r.width * .2, r.height * .3),
          const Radius.circular(3),
        ),
        win,
      );
    }
  }

  void _drawPerson(
    Canvas canvas,
    Offset feet,
    double s,
    Color skin,
    Color shirt,
    double wave, {
    required bool waving,
    required bool facingRight,
  }) {
    final dir = facingRight ? 1.0 : -1.0;
    // Legs.
    final leg = Paint()
      ..color = const Color(0xFF334155)
      ..strokeWidth = 5 * s
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(feet.translate(-3 * s, -16 * s), feet.translate(-3 * s, 0), leg);
    canvas.drawLine(feet.translate(3 * s, -16 * s), feet.translate(3 * s, 0), leg);
    // Torso.
    final torso = RRect.fromRectAndRadius(
      Rect.fromCenter(center: feet.translate(0, -26 * s), width: 15 * s, height: 20 * s),
      Radius.circular(6 * s),
    );
    canvas.drawRRect(torso, Paint()..color = shirt);
    // Arms: one at the side, one waving toward the van.
    final arm = Paint()
      ..color = skin
      ..strokeWidth = 4 * s
      ..strokeCap = StrokeCap.round;
    final shoulderBack = feet.translate(-dir * 6 * s, -32 * s);
    canvas.drawLine(shoulderBack, shoulderBack.translate(-dir * 1 * s, 12 * s), arm);
    final shoulder = feet.translate(dir * 6 * s, -32 * s);
    // Raised and swinging while waving, otherwise hanging by the side.
    final angle = waving ? (-1.9 + wave * .6) : 1.45;
    final hand = shoulder.translate(
      math.cos(angle) * 13 * s * dir,
      math.sin(angle) * 13 * s,
    );
    canvas.drawLine(shoulder, hand, arm);
    canvas.drawCircle(hand, 2.6 * s, Paint()..color = skin);
    // Head and hair.
    final head = feet.translate(0, -43 * s);
    canvas.drawCircle(head, 7.5 * s, Paint()..color = skin);
    canvas.drawArc(
      Rect.fromCircle(center: head, radius: 7.7 * s),
      math.pi,
      math.pi,
      true,
      Paint()..color = const Color(0xFF1F2937),
    );
  }
}

void _drawVan(Canvas canvas, Offset origin, double w, double wheelTurn) {
  final h = w * .46;
  final top = origin.dy - h;
  final left = origin.dx;

  // Cargo box with groceries visible over the top rail.
  final cargo = Rect.fromLTWH(left, top + h * .16, w * .64, h * .66);
  canvas.drawRRect(
    RRect.fromRectAndRadius(cargo, Radius.circular(w * .02)),
    Paint()..color = TowrisBrand.green,
  );
  canvas.drawRRect(
    RRect.fromRectAndRadius(cargo.deflate(w * .012), Radius.circular(w * .015)),
    Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF3FA66C), Color(0xFF1F7A47)],
      ).createShader(cargo),
  );

  // Groceries stacked on the roof: crates, produce, bread, bottles.
  final crateY = cargo.top;
  void crate(double x, double cw, double ch, Color c) {
    final r = Rect.fromLTWH(left + x, crateY - ch, cw, ch);
    canvas.drawRRect(RRect.fromRectAndRadius(r, Radius.circular(w * .008)), Paint()..color = c);
    canvas.drawLine(
      Offset(r.left + 2, r.top + ch * .45),
      Offset(r.right - 2, r.top + ch * .45),
      Paint()
        ..color = Colors.black.withOpacity(.12)
        ..strokeWidth = 1.5,
    );
  }

  crate(w * .03, w * .2, h * .19, const Color(0xFFC9955B));
  crate(w * .25, w * .17, h * .24, const Color(0xFFB57F45));
  crate(w * .43, w * .18, h * .17, const Color(0xFFC9955B));
  // Produce poking out of the crates.
  void fruit(double x, double y, double r, Color c) =>
      canvas.drawCircle(Offset(left + x, crateY - y), r, Paint()..color = c);
  fruit(w * .06, h * .22, w * .022, const Color(0xFFF97316));
  fruit(w * .1, h * .23, w * .022, const Color(0xFFEF4444));
  fruit(w * .15, h * .22, w * .022, const Color(0xFFF97316));
  fruit(w * .19, h * .21, w * .02, const Color(0xFF84CC16));
  fruit(w * .29, h * .27, w * .022, const Color(0xFF22C55E));
  fruit(w * .34, h * .28, w * .022, const Color(0xFF16A34A));
  fruit(w * .4, h * .26, w * .02, const Color(0xFF22C55E));
  // Bread loaf.
  canvas.drawRRect(
    RRect.fromRectAndRadius(
      Rect.fromLTWH(left + w * .46, crateY - h * .25, w * .13, h * .09),
      Radius.circular(w * .02),
    ),
    Paint()..color = const Color(0xFFE9B872),
  );
  // Milk carton.
  canvas.drawRect(
    Rect.fromLTWH(left + w * .53, crateY - h * .27, w * .05, h * .1),
    Paint()..color = Colors.white,
  );
  canvas.drawRect(
    Rect.fromLTWH(left + w * .53, crateY - h * .27, w * .05, h * .03),
    Paint()..color = const Color(0xFF60A5FA),
  );

  // Wordmark on the cargo box.
  final tp = TextPainter(
    text: TextSpan(
      text: 'TOWRIS',
      style: TextStyle(
        color: Colors.white,
        fontSize: w * .085,
        fontWeight: FontWeight.w800,
        letterSpacing: w * .006,
      ),
    ),
    textDirection: TextDirection.ltr,
  )..layout();
  tp.paint(canvas, Offset(cargo.center.dx - tp.width / 2, cargo.center.dy - tp.height / 2));

  // Cab.
  final cab = Path()
    ..moveTo(left + w * .64, top + h * .26)
    ..lineTo(left + w * .84, top + h * .26)
    ..quadraticBezierTo(left + w * .93, top + h * .3, left + w * .97, top + h * .52)
    ..lineTo(left + w * .99, top + h * .82)
    ..lineTo(left + w * .64, top + h * .82)
    ..close();
  canvas.drawPath(cab, Paint()..color = TowrisBrand.deepGreen);
  final windshield = Path()
    ..moveTo(left + w * .68, top + h * .32)
    ..lineTo(left + w * .83, top + h * .32)
    ..quadraticBezierTo(left + w * .9, top + h * .36, left + w * .93, top + h * .52)
    ..lineTo(left + w * .68, top + h * .52)
    ..close();
  canvas.drawPath(windshield, Paint()..color = const Color(0xFFCFEAF7));
  // Headlight and bumper.
  canvas.drawCircle(
    Offset(left + w * .965, top + h * .66),
    w * .016,
    Paint()..color = const Color(0xFFFFE08A),
  );
  canvas.drawRRect(
    RRect.fromRectAndRadius(
      Rect.fromLTWH(left + w * .62, top + h * .8, w * .38, h * .06),
      Radius.circular(w * .01),
    ),
    Paint()..color = const Color(0xFF0B2A1A),
  );

  // Wheels.
  for (final cx in [w * .2, w * .79]) {
    final c = Offset(left + cx, origin.dy - h * .02);
    final r = h * .17;
    canvas.drawCircle(c, r, Paint()..color = const Color(0xFF111827));
    canvas.drawCircle(c, r * .58, Paint()..color = const Color(0xFFD1D5DB));
    final spoke = Paint()
      ..color = const Color(0xFF6B7280)
      ..strokeWidth = 2;
    for (var i = 0; i < 5; i++) {
      final a = wheelTurn + i * 2 * math.pi / 5;
      canvas.drawLine(c, c + Offset(math.cos(a), math.sin(a)) * r * .56, spoke);
    }
    canvas.drawCircle(c, r * .14, Paint()..color = const Color(0xFF374151));
  }
}
