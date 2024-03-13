import 'package:dartz/dartz.dart';
import 'package:eesup_data_source/notifications/data_source/notification_data_source.dart';
import 'package:eesup_data_source/notifications/models/notification.dart';
import 'package:eesup_repository/auth/auth_repository.dart';
import 'package:eesup_repository/utils/eesup_exception.dart';


class NotificationRepo {
  final AuthRepository _authRepository;
  final NotificationDataSource _supaSource;

  NotificationRepo(this._authRepository, this._supaSource);

  Stream<Either<EESUpException, List<Notification>>> streamNotifications() {
    return _authRepository.executeStreamWithAuth((id) {
      return _supaSource.streamNotifications(id);
    });
  }

  Future<Either<EESUpException, void>> deleteNotification(int id) async {
    return _authRepository.executeWithAuth(
      (_) => _supaSource.deleteNotification(id),
    );
  }
}
