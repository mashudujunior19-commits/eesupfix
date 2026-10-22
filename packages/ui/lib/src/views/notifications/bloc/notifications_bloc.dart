import 'package:bloc/bloc.dart';
import 'package:data/notifications/models/notification.dart';
import 'package:data/notifications/repository/notification_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:meta/meta.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationRepo _repo;
  List<Notification> notifications = [];
  NotificationsBloc(this._repo) : super(NotificationsInitial()) {
    on<NotificationStreamStarted>((event, emit) async {
      final stream = _repo.streamNotifications();
      await emit.forEach(stream, onData: (results) {
        return results.fold((left) {
          return NotificationsError(left);
        }, (right) {
          notifications = right;
          return NotificationsStreaming(right);
        });
      });
    });
    // Notifications are never deleted from the app: viewing one only flags it
    // as seen. Old ones are purged server-side after 30 days.
    on<MarkNotificationsSeenEvent>((event, emit) async {
      final now = DateTime.now();
      final ids = event.notificationIds.toSet();
      notifications = [
        for (final n in notifications)
          if (ids.contains(n.id) && n.seenAt == null)
            n.copyWith(seenAt: now)
          else
            n
      ];
      emit(NotificationsStreaming(List.of(notifications)));
      for (final id in ids) {
        await _repo.markSeen(id);
      }
    });
  }
}
