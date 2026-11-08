import 'package:data/finance/models/wallet.dart';
import 'package:data/finance/models/wallet_rules.dart';
import 'package:data/notifications/models/notification.dart' as not;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/src/core/widgets/eesup_dropdown_form_field.dart';
import 'package:ui/src/views/notifications/ui/notification_tile.dart';

Wallet _wallet(String type) => Wallet(
      id: 1,
      userId: 'u1',
      balance: 0,
      typeId: type,
      description: type,
      createdAt: DateTime(2026, 1, 1),
      typeCreatedAt: DateTime(2026, 1, 1),
      withdrawals: true,
      deposits: true,
      transfers: true,
      shopping: true,
      isActive: true,
      requireRsaId: false,
      sortNumber: 1,
    );

Widget _host(Widget child) => MaterialApp(
      home: MediaQuery(
        data: const MediaQueryData(
          size: Size(320, 640),
          textScaler: TextScaler.linear(2),
        ),
        child: Scaffold(body: SingleChildScrollView(child: child)),
      ),
    );

void main() {
  group('wallet menu rules', () {
    test('social: transfer yes, payout no, commit no', () {
      final w = _wallet('social');
      expect(w.canTransfer, isTrue);
      expect(w.canRequestPayout, isFalse);
      expect(w.canCommit, isFalse);
    });

    test('wealth: commit only, no transfer, no payout', () {
      final w = _wallet('wealth');
      expect(w.canCommit, isTrue);
      expect(w.canTransfer, isFalse);
      expect(w.canRequestPayout, isFalse);
    });

    test('income and retail are unchanged', () {
      for (final t in ['income', 'retail']) {
        final w = _wallet(t);
        expect(w.canTransfer, isTrue, reason: t);
        expect(w.canRequestPayout, isTrue, reason: t);
        expect(w.canCommit, isFalse, reason: t);
      }
    });

    test('commit needs strictly more than R500 available', () {
      expect(minWealthCommitBalance, 500);
      expect(canCommitWithBalance(99.96), isFalse);
      expect(canCommitWithBalance(500), isFalse);
      expect(canCommitWithBalance(500.01), isTrue);
    });
  });

  group('no overflow on a 320x640 screen with large text', () {
    testWidgets('notification tile with a long title', (tester) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(_host(NotificationTile(
        notification: not.Notification(
          id: 1,
          title: 'Tesoj 61030 declined your invite to join a very long pool',
          body: 'Tesoj 61030 declined your invite to join wozaguys.',
          createdAt: DateTime(2026, 11, 2, 9, 19),
          type: not.NotificationType.other,
        ),
      )));
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.textContaining('Tesoj 61030 declined'), findsWidgets);
    });

    testWidgets('labelled dropdown (Transfer recipient type)', (tester) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(_host(EESUpDropdownFormField<String>(
        label: 'Recipient Type',
        value: 'KasiLift Organisation',
        items: const ['KasiLift Organisation'],
        itemLabel: (t) => t,
        onChanged: (_) {},
      )));
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.text('Recipient Type'), findsOneWidget);
      expect(find.text('KasiLift Organisation'), findsWidgets);
    });
  });
}
