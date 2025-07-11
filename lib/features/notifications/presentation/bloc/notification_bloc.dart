import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/notification_repository.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository _notificationRepository;

  NotificationBloc({
    required NotificationRepository notificationRepository,
  })  : _notificationRepository = notificationRepository,
        super(NotificationInitial()) {
    on<LoadNotifications>(_onLoadNotifications);
    on<LoadNotificationDetail>(_onLoadNotificationDetail);
    on<MarkNotificationAsRead>(_onMarkNotificationAsRead);
    on<DeleteNotification>(_onDeleteNotification);
  }

  Future<void> _onLoadNotifications(
    LoadNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    print('🔥 LoadNotifications được gọi! Current state: ${state.runtimeType}');
    print('🔥 StackTrace: ${StackTrace.current}');
    emit(NotificationsLoading());
    try {
      final notifications = await _notificationRepository.getNotifications();
      emit(NotificationsLoaded(notifications));
    } catch (e) {
      emit(NotificationActionFailed(e.toString()));
    }
  }

  Future<void> _onLoadNotificationDetail(
    LoadNotificationDetail event,
    Emitter<NotificationState> emit,
  ) async {
    print(' LoadNotificationDetail được gọi với ID: ${event.id}');
    print(' Current state trước khi emit: ${state.runtimeType}');
    emit(NotificationDetailLoading());
    try {
      final notification =
          await _notificationRepository.getNotificationById(event.id);

      if (notification != null) {
        if (!notification.isRead) {
          print(' Marking notification as read: ${notification.id}');
          await _notificationRepository.markAsRead(event.id);
          final updatedNotification = notification.copyWith(isRead: true);
          emit(NotificationDetailLoaded(updatedNotification));
          print('Emitted NotificationDetailLoaded với notification đã đọc');
        } else {
          emit(NotificationDetailLoaded(notification));
          print('Emitted NotificationDetailLoaded với notification đã có sẵn');
        }
        print(' Notification loaded: ${notification.title}');
      } else {
        print('Không tìm thấy notification với ID: ${event.id}');
        emit(const NotificationActionFailed('Không tìm thấy thông báo'));
      }
    } catch (e) {
      print(' Lỗi khi load notification detail: $e');
      emit(NotificationActionFailed(e.toString()));
    }
  }

  Future<void> _onMarkNotificationAsRead(
    MarkNotificationAsRead event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await _notificationRepository.markAsRead(event.id);

      if (state is NotificationsLoaded) {
        final currentState = state as NotificationsLoaded;
        final updatedNotifications =
            currentState.notifications.map((notification) {
          if (notification.id == event.id) {
            return notification.copyWith(isRead: true);
          }
          return notification;
        }).toList();

        emit(NotificationsLoaded(updatedNotifications));
      }
    } catch (e) {
      print('Lỗi khi đánh dấu đã đọc: $e');
    }
  }

  Future<void> _onDeleteNotification(
    DeleteNotification event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await _notificationRepository.deleteNotification(event.id);
      emit(const NotificationActionSuccess('Xóa thông báo thành công'));

      print(' Đã xóa thông báo thành công');
    } catch (e) {
      emit(NotificationActionFailed(e.toString()));
    }
  }
}
