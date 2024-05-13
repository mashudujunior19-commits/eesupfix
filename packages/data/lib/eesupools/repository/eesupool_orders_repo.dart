import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:data/eesupools/models/eesupool_order.dart';
import 'eesupool_repo.dart';

extension EESUpoolOrdersRepo on EESUpoolRepository {
  Future<Either<EESUpException, List<EESUpoolOrder>>> fetchEESUpoolOrders(
    int poolId,
    int limit,
  ) async {
    final result = await authRepository.executeFutureWithAuth((_) {
      return dataSource.fetchEESUpoolOrders(poolId, limit);
    });
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  Future<Either<EESUpException, List<EESUpoolOrder>>>
      fetchOpenEESUpoolOrders() async {
    final result = await authRepository.executeFutureWithAuth((id) {
      return dataSource.fetchUserOpenEESUpoolOrders(id);
    });
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  Future<Either<EESUpException, bool>> createOrder(EESUpoolOrder order) async {
    final result = await authRepository.executeFutureWithAuth((id) {
      return dataSource.createEESUpoolOrder(order);
    });

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  Future<Either<EESUpException, bool>> updateOrder(EESUpoolOrder order) async {
    final result = await authRepository.executeFutureWithAuth((id) {
      return dataSource.updateEESUpoolOrder(order);
    });
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  Future<Either<EESUpException, EESUpoolOrder?>> fetchOpenOrder(
      int poolId) async {
    final result = await authRepository.executeFutureWithAuth((_) {
      return dataSource.fetchEESUpoolOpenOrder(poolId);
    });
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  Future<Either<EESUpException, bool>> updateOrderAssignments(
    List<MemberOrderAssignment> assignments,
    int orderId,
  ) async {
    final result = await authRepository.executeFutureWithAuth((_) {
      return dataSource.updateMemberOrderAssignments(assignments, orderId);
    });
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
