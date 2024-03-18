import 'package:dartz/dartz.dart';
import 'package:data_sources/notifications/data_source/notification_data_source.dart';
import 'package:data_sources/notifications/models/notification.dart';
import 'package:repository/auth/auth_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

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
