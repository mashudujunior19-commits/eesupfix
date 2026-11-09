import 'package:data/auth/models/user_role.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ui/src/views/menu/get_involved_sheet.dart';

void main() {
  group('Get Involved list', () {
    Future<void> pump(WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => GetInvolvedSheet(
              role: UserRole.Ubuntunist,
              hostContext: context,
            ),
          ),
        ),
      ));
    }

    testWidgets('lists Kasipreneur and KasiSpaza as their own items',
        (tester) async {
      await pump(tester);
      expect(find.text('Kasipreneur'), findsOneWidget);
      expect(find.text('KasiSpaza'), findsOneWidget);
      expect(find.text('Become a Vendor'), findsOneWidget);
      expect(find.textContaining('Register a business'), findsWidgets);
      expect(find.text('Upgrade to KasiLift Organisation'), findsOneWidget);
      expect(find.text('Become a Kasipromoter'), findsOneWidget);
    });

    testWidgets('Become a Vendor describes only vendor listings',
        (tester) async {
      await pump(tester);
      expect(find.text('Apply to have your service or product listed.'),
          findsOneWidget);
      // Kasipreneur and KasiSpaza each appear once, as their own items.
      expect(find.text('Kasipreneur'), findsOneWidget);
      expect(find.text('KasiSpaza'), findsOneWidget);
    });
  });

  group('exact messages', () {
    test('the Kasipromoter refusal is word for word', () {
      expect(
        kasipromoterBlockedMessage,
        'You cannot be a Kasipromoter. Only a Kasilift Organisation can refer '
        'and become a Kasipromoter.',
      );
    });

    test('database rule messages reach the user unchanged', () {
      for (final (code, message) in [
        ('PT422', 'Enter a valid South African phone number.'),
        ('PT409', 'You already have a pending application.'),
        ('PT403', kasipromoterBlockedMessage),
        ('PT409', 'This phone number is already linked to another account.'),
      ]) {
        final result = EESUpException.guardValue<bool>(
          action: () => throw PostgrestException(message: message, code: code),
        );
        expect(result.isLeft, isTrue);
        expect(result.fold((l) => l.message, (r) => ''), message);
      }
    });

    test('an ordinary unique violation still gets the generic text', () {
      final result = EESUpException.guardValue<bool>(
        action: () => throw PostgrestException(message: 'dup', code: '23505'),
      );
      expect(result.fold((l) => l.message, (r) => ''),
          'This record already exists.');
    });
  });
}
