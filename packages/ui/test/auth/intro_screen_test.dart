import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/src/views/auth/intro/intro_screen.dart';
import 'package:ui/src/views/auth/intro/intro_seen.dart';

/// The intro with animations off (as with "reduce motion"), so the looping
/// scenes are drawn still and pumpAndSettle can finish.
Widget _app() => MaterialApp(
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(disableAnimations: true),
        child: child!,
      ),
      home: const IntroScreen(),
    );

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('pages through the intro to Get Started', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    expect(find.text('Shop for food, together'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);

    await tester.tap(find.byKey(const Key('intro_next')));
    await tester.pumpAndSettle();
    expect(find.text('Join a KasiPool'), findsOneWidget);

    await tester.tap(find.byKey(const Key('intro_next')));
    await tester.pumpAndSettle();
    expect(find.text('Earn rewards'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
    expect(find.text('Already have an account? Sign in'), findsOneWidget);

    expect(tester.takeException(), isNull);
  });

  testWidgets('fits a small phone without overflow', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 568));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();
    for (var i = 0; i < 2; i++) {
      await tester.tap(find.byKey(const Key('intro_next')));
      await tester.pumpAndSettle();
    }

    expect(tester.takeException(), isNull);
  });

  testWidgets('scenes animate without errors', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MaterialApp(home: IntroScreen()));
    for (var page = 0; page < 3; page++) {
      for (var i = 0; i < 20; i++) {
        await tester.pump(const Duration(milliseconds: 150));
      }
      if (page < 2) {
        await tester.tap(find.byKey(const Key('intro_next')));
        await tester.pump(const Duration(milliseconds: 500));
      }
    }

    expect(tester.takeException(), isNull);
    // Leave the looping animations behind before the test ends.
    await tester.pumpWidget(const SizedBox());
  });

  test('shows until someone signs in on the device', () async {
    expect(await IntroSeen.get(), isFalse);
    await IntroSeen.markSeen();
    expect(await IntroSeen.get(), isTrue);
  });
}
