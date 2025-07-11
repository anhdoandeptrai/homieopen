import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotifications extends NotificationEvent {}

class LoadNotificationDetail extends NotificationEvent {
  final String id;

  const LoadNotificationDetail(this.id);

  @override
  List<Object?> get props => [id];
}

class MarkNotificationAsRead extends NotificationEvent {
  final String id;

  const MarkNotificationAsRead(this.id);

  @override
  List<Object?> get props => [id];
}

class DeleteNotification extends NotificationEvent {
  final String id;

  const DeleteNotification(this.id);

  @override
  List<Object?> get props => [id];
}

class SyncNotifications extends NotificationEvent {
  final bool showLoading;

  const SyncNotifications({this.showLoading = true});

  @override
  List<Object?> get props => [showLoading];
}

class MarkAllNotificationsAsRead extends NotificationEvent {}
