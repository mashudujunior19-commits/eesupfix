import 'package:data/order_confirmation/models/order_confirmation.dart';
import 'package:data/order_confirmation/repository/order_confirmation_repository.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui/src/views/order_confirmation/cubit/confirm_order_cubit.dart';

class MockRepo extends Mock implements OrderConfirmationRepository {}

void main() {
  late MockRepo repo;

  const confirmation = OrderConfirmation(
    orderId: 7,
    canConfirm: true,
    lines: [
      ConfirmationLine(productId: 1, name: 'Rice', orderedQty: 3),
      ConfirmationLine(productId: 2, name: 'Oil', orderedQty: 1),
    ],
  );

  setUp(() {
    repo = MockRepo();
    when(() => repo.getConfirmation(7))
        .thenAnswer((_) async => const Right(confirmation));
  });

  test('defaults to ordered quantities and is valid', () async {
    final cubit = ConfirmOrderCubit(repo, 7);
    await cubit.load();
    final s = cubit.state as ConfirmOrderEditing;
    expect(s.isValid, isTrue);
    expect(s.receivedTotal, 4);
  });

  test('short line needs remedy, and backorder needs when', () async {
    final cubit = ConfirmOrderCubit(repo, 7);
    await cubit.load();
    cubit.setReceived(1, 1);
    expect((cubit.state as ConfirmOrderEditing).isValid, isFalse);
    cubit.setRemedy(1, ConfirmationRemedy.backorder);
    expect((cubit.state as ConfirmOrderEditing).isValid, isFalse);
    cubit.setBackorderWhen(1, BackorderWhen.nextRoute);
    final s = cubit.state as ConfirmOrderEditing;
    expect(s.isValid, isTrue);
    expect(s.backorderCount, 2);
    cubit.setReceived(1, 3);
    expect((cubit.state as ConfirmOrderEditing).entries.first.remedy, isNull);
  });

  test('submit sends all lines with one idempotency key; already_confirmed ok',
      () async {
    when(() => repo.confirm(
          orderId: any(named: 'orderId'),
          lines: any(named: 'lines'),
          idempotencyKey: any(named: 'idempotencyKey'),
        )).thenAnswer((_) async => const Right(ConfirmResult(
          ok: true,
          orderId: 7,
          alreadyConfirmed: true,
          orderedTotal: 4,
          receivedTotal: 4,
        )));
    final cubit = ConfirmOrderCubit(repo, 7, idempotencyKey: 'k1');
    await cubit.load();
    await cubit.submit();
    expect(cubit.state, isA<ConfirmOrderDone>());
    final captured = verify(() => repo.confirm(
          orderId: 7,
          lines: captureAny(named: 'lines'),
          idempotencyKey: 'k1',
        )).captured.single as List<ConfirmationLineInput>;
    expect(captured.length, 2);
  });
}
