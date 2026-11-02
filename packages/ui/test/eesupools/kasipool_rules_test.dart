import 'package:bloc_test/bloc_test.dart';
import 'package:data/eesupools/kasipool_rules.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/eesupools/models/eesupool_order.dart';
import 'package:data/eesupools/models/receiver_role.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui/src/views/eesupools/ui/tabs/orders/bloc/order_receivers_bloc.dart';

class MockPoolRepo extends Mock implements EESUpoolRepository {}

EESUpoolOrder _order({
  String? status,
  double amount = 0,
  DateTime? closesAt,
  DateTime? deliveredAt,
}) =>
    EESUpoolOrder(
      id: 1,
      eesupoolId: 1,
      createdAt: DateTime(2026, 1, 1),
      scheduleFor: DateTime(2026, 1, 5),
      closesAt: closesAt ?? DateTime(2026, 1, 4),
      status: status,
      deliveredAt: deliveredAt,
      currentAmount: amount,
    );

EESUpoolMember _member(String id, {bool? verified = true}) => EESUpoolMember(
      memberId: id,
      eesupoolId: 1,
      userId: 'u-$id',
      role: EESUpoolMemberRole.member,
      isCensored: false,
      fullName: 'Member $id',
      createdAt: DateTime(2026, 1, 1),
      isVerified: verified,
    );

void main() {
  group('minimum order', () {
    test('is R10,000 in one place', () {
      expect(minKasipoolOrder, 10000);
    });

    test('an order below the minimum cannot be closed from the UI', () {
      expect(_order(amount: 9565.01).meetsMinimum, isFalse);
      expect(_order(amount: 0).meetsMinimum, isFalse);
      expect(_order(amount: 10000).meetsMinimum, isTrue);
    });
  });

  group('isClosed', () {
    test('uses the database status when present', () {
      expect(_order(status: 'Closed').isClosed, isTrue);
      expect(
        _order(status: 'Open', closesAt: DateTime(2000)).isClosed,
        isFalse,
      );
    });

    test('a received order is closed', () {
      expect(_order(status: 'Open', deliveredAt: DateTime(2026)).isClosed,
          isTrue);
    });

    test('falls back to the closing date without a status', () {
      expect(_order(closesAt: DateTime(2000)).isClosed, isTrue);
      expect(
        _order(closesAt: DateTime.now().add(const Duration(days: 1))).isClosed,
        isFalse,
      );
    });
  });

  group('OrderReceiversBloc', () {
    late MockPoolRepo repo;
    final existing = _member('a');

    setUp(() {
      repo = MockPoolRepo();
    });

    blocTest<OrderReceiversBloc, OrderReceiversState>(
      'adds a receiver with the Bulk Order Receiver role',
      build: () {
        when(() => repo.addOrderReceiver(1, 'b'))
            .thenAnswer((_) async => const Right(true));
        return OrderReceiversBloc(repo);
      },
      seed: () => OrderReceiversLoaded([existing]),
      act: (b) => b.add(OrderReceiverAdded(1, _member('b'))),
      expect: () => [
        isA<OrderReceiversLoaded>()
            .having((s) => s.receivers.length, 'receivers', 2)
            .having((s) => s.roles['b'], 'role', ReceiverRole.receiver)
            .having((s) => s.saveError, 'error', isNull),
      ],
    );

    blocTest<OrderReceiversBloc, OrderReceiversState>(
      'adding the same member twice is refused with a friendly message',
      build: () => OrderReceiversBloc(repo),
      seed: () => OrderReceiversLoaded([existing]),
      act: (b) => b.add(OrderReceiverAdded(1, _member('a'))),
      expect: () => [
        isA<OrderReceiversLoaded>().having(
            (s) => s.saveError, 'error', contains('already a receiver')),
      ],
      verify: (_) => verifyNever(() => repo.addOrderReceiver(any(), any())),
    );

    blocTest<OrderReceiversBloc, OrderReceiversState>(
      'a refused save (e.g. order closed) is reported and not applied',
      build: () {
        when(() => repo.addOrderReceiver(1, 'b')).thenAnswer((_) async => Left(
            EESUpException(
                message: 'Receivers cannot be assigned or changed once the '
                    'order is closed.')));
        return OrderReceiversBloc(repo);
      },
      seed: () => OrderReceiversLoaded([existing]),
      act: (b) => b.add(OrderReceiverAdded(1, _member('b'))),
      expect: () => [
        isA<OrderReceiversLoaded>()
            .having((s) => s.receivers.length, 'receivers', 1)
            .having((s) => s.saveError, 'error', contains('closed')),
      ],
    );
  });
}
