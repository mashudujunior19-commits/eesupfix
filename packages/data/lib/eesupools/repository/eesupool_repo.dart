import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_level.dart';
import 'package:data/eesupools/models/eesupool_type.dart';
import 'package:data/eesupools/data_source/eesupool_data_source.dart';

class EESUpoolRepository {
  final AuthRepository authRepository;
  final EESUpoolDataSource dataSource;

  EESUpoolRepository({
    required this.authRepository,
    required this.dataSource,
  });

  Future<Either<EESUpException, List<EESUpool>>> fetchUserEESUpools(
    EESUpoolType type,
  ) async {
    final result = authRepository.executeFutureWithAuth((id) {
      return dataSource.fetchEESUpools(id, type);
    });
    return result;
  }

  Future<Either<EESUpException, bool>> updatePoolOrderReceivers(
    int orderId,
    List<String> memberIds,
  ) async {
    final result = authRepository.executeFutureWithAuth((_) {
      return dataSource.updatePoolOrderReceivers(orderId, memberIds);
    });
    return result;
  }

  Future<Either<EESUpException, List<EESUpoolMember>>>
      fetchEESUpoolMembersByIdsArray(List<String> ids) async {
    final result = authRepository.executeFutureWithAuth((_) {
      return dataSource.fetchMembersByIdList(ids);
    });
    return result;
  }

  Future<Either<EESUpException, List<EESUpool>>> fetchEESUpoolsDescendents({
    required int poolId,
    required int limit,
  }) async {
    final result = authRepository.executeFutureWithAuth((id) {
      return dataSource.fetchEESUpoolDescendants(
          poolId: poolId, userId: id, limit: limit);
    });
    return result;
  }

  Future<Either<EESUpException, List<EESUpool>>> searchEESUpoolsDescendents({
    required String query,
    required int poolId,
    required int limit,
  }) async {
    final result = authRepository.executeFutureWithAuth((id) {
      return dataSource.searchEESUpoolDescendants(
        query: query,
        poolId: poolId,
        userId: id,
        limit: limit,
      );
    });
    return result;
  }

  Future<Either<EESUpException, List<EESUpool>>> searchUserEESUpools({
    required String query,
    required EESUpoolType type,
    required int limit,
  }) async {
    final result = authRepository.executeFutureWithAuth((id) {
      return dataSource.searchUserEESUpools(
        query: query,
        userId: id,
        type: type,
        limit: limit,
      );
    });
    return result;
  }

  Future<Either<EESUpException, int?>> createEESUpool({
    required String name,
    String? description,
    int? parent,
    EESUpoolLevel? level,
    required EESUpoolType type,
  }) async {
    final result = authRepository.executeFutureWithAuth((id) {
      return dataSource.createEESUpool(
        sessionId: id,
        name: name,
        description: description,
        parent: parent,
        level: level,
        type: type,
      );
    });

    return result;
  }

  Future<Either<EESUpException, void>> updateEESUpool(EESUpool pool) async {
    final sessionId = authRepository.sessionId;
    if (sessionId == null) {
      return Left(
        EESUpAuthException(
          message: 'You are not logged in',
        ),
      );
    }

    final result = await EESUpException.guardFuture(
      action: () => dataSource.updatePool(pool),
    );

    return result;
  }

  Future<Either<EESUpException, EESUpool>> fetchEESUpoolById(int poolId) {
    final result = authRepository.executeFutureWithAuth((id) {
      return dataSource.fetchEESUpool(poolId, id);
    });
    return result;
  }

  Future<Either<EESUpException, int>> countUserEESUpoolsByType(
      EESUpoolType type) {
    final result = authRepository.executeFutureWithAuth((id) {
      return dataSource.countEESUpoolByType(id, type);
    });
    return result;
  }

  Future<Either<EESUpException, void>> acceptEESUpoolInvite(
      String userId, int poolId) async {
    final result = authRepository.executeFutureWithAuth((id) {
      return dataSource.acceptEESUpoolInvite(userId, poolId);
    });
    return result;
  }
}
