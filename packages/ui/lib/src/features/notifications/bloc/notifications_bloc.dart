import 'package:bloc/bloc.dart';
import 'package:data/notifications/models/notification.dart';
import 'package:data/notifications/repository/notification_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:meta/meta.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationRepo _repo;
  NotificationsBloc(this._repo) : super(NotificationsInitial()) {
    on<NotificationStreamStarted>((event, emit) async {
      final stream = _repo.streamNotifications();
      await emit.forEach(stream, onData: (results) {
        return results.fold((left) {
          return NotificationsError(left);
        }, (right) {
          return NotificationsStreaming(right);
        });
      });
    });
  }
}
