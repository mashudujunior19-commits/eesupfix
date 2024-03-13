import 'package:dartz/dartz.dart';
import 'package:eesup_data_source/eesupools/models/eesupool_member.dart';
import 'package:eesup_data_source/eesupools/models/eesupool_request.dart';
import 'package:eesup_data_source/eesupools/models/eesupool_type.dart';
import 'package:eesup_repository/eesupools/eesupool_repo.dart';
import 'package:eesup_repository/utils/eesup_exception.dart';

//TODO: Add Authentication wrapper on all functions
extension EESUpoolMembersRepo on EESUpoolRepository {
  Future<Either<EESUpException, List<EESUpoolMember>>> fetchEESUpoolMembers(
    int poolId,
    int limit,
  ) async {
    final sessionId = authRepository.sessionId;
    if (sessionId == null) {
      return Left(
        EESUpAuthException(message: 'You are not logged in'),
      );
    }

    final result = await EESUpException.guardFuture(
      action: () => dataSource.fetchEESUpoolMembers(poolId, limit),
    );
    return result;
  }

  Future<Either<EESUpException, void>> updateEESUpoolMember(
    EESUpoolMember member,
  ) async {
    final sessionId = authRepository.sessionId;
    if (sessionId == null) {
      return Left(
        EESUpAuthException(message: 'You are not logged in'),
      );
    }

    final result = await EESUpException.guardFuture(
      action: () => dataSource.updatePoolMember(member),
    );
    return result;
  }

  Future<Either<EESUpException, dynamic>> searchProfileForInvites(
    String query,
    int poolId,
    int limit,
  ) async {
    final sessionId = authRepository.sessionId;
    if (sessionId == null) {
      return Left(
        EESUpAuthException(message: 'You are not logged in'),
      );
    }

    final result = await EESUpException.guardFuture(
        action: () => dataSource.searchProfilesForInvites(
              poolId: poolId,
              query: query,
              limit: limit,
            ));
    return result;
  }

  Future<Either<EESUpException, List<EESUpoolRequest>>>
      fetchEESUpoolInviteAndRequests(
    String type,
    int poolId,
    int limit,
  ) async {
    final sessionId = authRepository.sessionId;
    if (sessionId == null) {
      return Left(
        EESUpAuthException(message: 'You are not logged in'),
      );
    }

    final result = await EESUpException.guardFuture(
        action: () => dataSource.fetchEESUpoolRequests(
              poolId: poolId,
              type: type,
              limit: limit,
            ));
    return result;
  }

  Future<Either<EESUpException, void>> createEESUpooolRequest(
      int poolId) async {
    final result = await authRepository.executeFutureWithAuth((id) {
      return dataSource.createEESUpoolRequest(id, poolId, 'Request');
    });
    return result;
  }

  Future<Either<EESUpException, void>> joinEESUpoool(
    int poolId,
  ) async {
    final result = await authRepository.executeFutureWithAuth((id) {
      return dataSource.joinKasi(id, poolId);
    });
    return result;
  }

  Future<Either<EESUpException, void>> createEESUpoolInvite(
      int poolId, String userId, String type) async {
    final sessionId = authRepository.sessionId;
    if (sessionId == null) {
      return Left(
        EESUpAuthException(message: 'You are not logged in'),
      );
    }

    final result = await EESUpException.guardFuture(
        action: () => dataSource.createEESUpoolRequest(userId, poolId, type));
    return result;
  }

  Future<Either<EESUpException, void>> deleteCurrentInviteOrRequest(
    int poolId,
  ) async {
    final results = await authRepository.executeFutureWithAuth((id) {
      return dataSource.deleteInviteOrRequest(id, poolId);
    });
    return results;
  }

  Future<Either<EESUpException, void>> deleteInviteOrRequest(
      String userId, int poolId) async {
    final sessionId = authRepository.sessionId;
    if (sessionId == null) {
      return Left(
        EESUpAuthException(message: 'You are not logged in'),
      );
    }

    final result = await EESUpException.guardFuture(
        action: () => dataSource.deleteInviteOrRequest(userId, poolId));
    return result;
  }

  Future<Either<EESUpException, void>> updateEESUpoolRequest(
      String userId, int poolId, String status) async {
    final sessionId = authRepository.sessionId;
    if (sessionId == null) {
      return Left(
        EESUpAuthException(message: 'You are not logged in'),
      );
    }

    final result = await EESUpException.guardFuture(
        action: () => dataSource.updateEESUpoolRequest(userId, poolId, status));
    return result;
  }

  Future<Either<EESUpException, dynamic>> searchTradePools(
    String query,
    int limit,
    double lat,
    double lng,
  ) async {
    final result = authRepository.executeFutureWithAuth((id) {
      return dataSource.searchTradePools(lat, lng, id, query, limit);
    });
    return result;
  }

  Future<Either<EESUpException, dynamic>> searchPoolsByType(
    String query,
    EESUpoolType type,
    int limit,
  ) async {
    final result = authRepository.executeFutureWithAuth((id) {
      final r = dataSource.searchPoolsByType(query, id, type, limit);
      return r;
    });
    return result;
  }

  Future<Either<EESUpException, bool>> joinKasiPool(int poolId) async {
    final result = authRepository.executeFutureWithAuth((id) {
      final r = dataSource.joinKasi(id, poolId);
      return r;
    });
    return result;
  }

  Future<Either<EESUpException, dynamic>> searchKasiStreetPoolsById(
      int parentId, int limit) async {
    final result = authRepository.executeFutureWithAuth((id) {
      final r = dataSource.KasiStreetsSearch(
          parentId: parentId, userId: id, limit: limit);
      return r;
    });
    return result;
  }

  Future<Either<EESUpException, bool>> transferMember(
    String memberId,
    int newPoolId,
    EESUpoolMemberRole role,
  ) async {
    final result = authRepository.executeFutureWithAuth((id) {
      final r = dataSource.transferMember(
        memberId: memberId,
        newPoolId: newPoolId,
        role: role,
      );
      return r;
    });
    return result;
  }

  Future<Either<EESUpException, bool>> leaveEESUpool(int poolId) async {
    final result = authRepository.executeFutureWithAuth((id) {
      final r = dataSource.deleteMember(poolId, id);
      return r;
    });
    return result;
  }
}
