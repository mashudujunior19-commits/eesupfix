import 'package:data/pool_progress/models/pool_order_progress.dart';
import 'package:data/pool_progress/repository/pool_progress_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui/src/views/pool_progress/cubit/pool_progress_cubit.dart';

class MockRepo extends Mock implements PoolProgressRepository {}

void main() {
  late MockRepo repo;
  void Function()? onEvent;

  setUp(() {
    repo = MockRepo();
    onEvent = null;
    when(() => repo.subscribe(any(), any())).thenAnswer((inv) {
      onEvent = inv.positionalArguments[1] as void Function();
      return null;
    });
  });

  test('empty progress renders Empty', () async {
    when(() => repo.getProgress(5)).thenAnswer(
        (_) async => const Right(PoolOrderProgress(eesupoolOrderId: 5)));
    final cubit = PoolProgressCubit(repo, 5);
    await cubit.start();
    expect(cubit.state, isA<PoolProgressEmpty>());
    await cubit.close();
  });

  test('loaded progress exposes timestamps', () async {
    final t = DateTime(2026, 10, 12, 9, 30);
    when(() => repo.getProgress(5)).thenAnswer((_) async =>
        Right(PoolOrderProgress(eesupoolOrderId: 5, packedAt: t)));
    final cubit = PoolProgressCubit(repo, 5);
    await cubit.start();
    final s = cubit.state as PoolProgressLoaded;
    expect(s.progress.packedAt, t);
    expect(s.progress.readyAt, isNull);
    await cubit.close();
  });

  test('refetches on a realtime event', () async {
    when(() => repo.getProgress(5)).thenAnswer(
        (_) async => const Right(PoolOrderProgress(eesupoolOrderId: 5)));
    final cubit = PoolProgressCubit(repo, 5);
    await cubit.start();
    expect(cubit.state, isA<PoolProgressEmpty>());

    final t = DateTime(2026, 10, 12, 11);
    when(() => repo.getProgress(5)).thenAnswer((_) async =>
        Right(PoolOrderProgress(eesupoolOrderId: 5, departedAt: t)));
    onEvent!();
    await Future<void>.delayed(Duration.zero);
    expect((cubit.state as PoolProgressLoaded).progress.departedAt, t);
    verify(() => repo.getProgress(5)).called(2);
    await cubit.close();
  });

  test('error stays hidden (Error state, never Loaded)', () async {
    when(() => repo.getProgress(5)).thenAnswer(
        (_) async => Left(EESUpException(message: 'boom')));
    final cubit = PoolProgressCubit(repo, 5);
    await cubit.start();
    expect(cubit.state, isA<PoolProgressError>());
    await cubit.close();
  });
}
