import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:data/notifications/data_source/notification_data_source.dart';
import 'package:data/notifications/models/notification.dart';


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
