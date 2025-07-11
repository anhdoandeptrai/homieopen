import 'package:app_homieopen_3047/features/notifications/models/notification_model.dart';
import 'package:equatable/equatable.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationsLoading extends NotificationState {}

class NotificationsLoaded extends NotificationState {
  final List<NotificationModel> notifications;

  const NotificationsLoaded(this.notifications);

  @override
  List<Object?> get props => [notifications];
}

class NotificationDetailLoading extends NotificationState {}

class NotificationDetailLoaded extends NotificationState {
  final NotificationModel notification;

  const NotificationDetailLoaded(this.notification);

  @override
  List<Object?> get props => [notification];
}

class NotificationActionSuccess extends NotificationState {
  final String message;

  const NotificationActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class NotificationActionFailed extends NotificationState {
  final String error;

  const NotificationActionFailed(this.error);

  @override
  List<Object?> get props => [error];
}

class NotificationSyncing extends NotificationState {}

class NotificationSyncSuccess extends NotificationState {
  final DateTime syncTime;

  const NotificationSyncSuccess(this.syncTime);

  @override
  List<Object?> get props => [syncTime];
}
