import 'package:dartz/dartz.dart';
import 'package:eesup_data_source/eesupools/models/eesupool_event.dart';
import 'package:eesup_repository/eesupools/eesupool_repo.dart';
import 'package:eesup_repository/utils/eesup_exception.dart';


//TODO: Add Authentication wrapper on all functions
extension EESUpoolEventsRepo on EESUpoolRepository {
  Future<Either<EESUpException, List<EESUpoolEvent>>> fetchEESUpoolEvents(
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
      action: () => dataSource.fetchEESUpoolEvents(poolId, limit),
    );
    return result;
  }

  Future<Either<EESUpException, void>> createEESUpoolEvent(
    EESUpoolEvent event,
  ) async {
    final sessionId = authRepository.sessionId;
    if (sessionId == null) {
      return Left(
        EESUpAuthException(message: 'You are not logged in'),
      );
    }

    final result = await EESUpException.guardFuture(
      action: () => dataSource.createEESUpoolEvent(event),
    );
    return result;
  }

  Future<Either<EESUpException, void>> updateEESUpoolEvent(
    EESUpoolEvent event,
  ) async {
    final sessionId = authRepository.sessionId;
    if (sessionId == null) {
      return Left(
        EESUpAuthException(message: 'You are not logged in'),
      );
    }

    final result = await EESUpException.guardFuture(
      action: () => dataSource.updateEESUpoolEvent(event),
    );
    return result;
  }

  Future<Either<EESUpException, void>> subEvent(
      String eventId, String memberId) async {
    final sessionId = authRepository.sessionId;
    if (sessionId == null) {
      return Left(
        EESUpAuthException(message: 'You are not logged in'),
      );
    }
    final result = await EESUpException.guardFuture(
      action: () => dataSource.subscribeToEvent(eventId, memberId),
    );
    return result;
  }

  Future<Either<EESUpException, void>> unsubEvent(
      String eventId, String memberId) async {
    final sessionId = authRepository.sessionId;
    if (sessionId == null) {
      return Left(
        EESUpAuthException(message: 'You are not logged in'),
      );
    }
    final result = await EESUpException.guardFuture(
      action: () => dataSource.unsubscribeFromEvent(eventId, memberId),
    );
    return result;
  }

  Future<Either<EESUpException, void>> updateEvent(EESUpoolEvent event) async {
    final sessionId = authRepository.sessionId;
    if (sessionId == null) {
      return Left(
        EESUpAuthException(message: 'You are not logged in'),
      );
    }
    final result = await EESUpException.guardFuture(
      action: () => dataSource.updateEvent(event),
    );
    return result;
  }
}
