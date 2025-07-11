import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';
import '../bloc/notification_state.dart';
import '../../models/notification_model.dart';
import 'notification_item.dart';
import 'notification_delete_dialog.dart';

class NotificationList extends StatelessWidget {
  final List<NotificationModel> notifications;
  final Function(NotificationModel) onNotificationTap;

  const NotificationList({
    super.key,
    required this.notifications,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        if (state is NotificationsLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.turquoise500,
            ),
          );
        }

        if (state is NotificationsLoaded) {
          final notifications = state.notifications;

          if (notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off_outlined,
                    size: 48,
                    color: AppColor.oslo400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Không có thông báo',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColor.oslo700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: notifications.length,
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              thickness: 0.5,
              color: Color(0xFF1A2E37),
              indent: 0,
              endIndent: 0,
            ),
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return Slidable(
                key: Key(notification.id),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 0.2,
                  children: [
                    CustomSlidableAction(
                      onPressed: (context) async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => NotificationDeleteDialog(
                            // onConfirm: () => Navigator.of(context).pop(true),
                            onConfirm: () => Navigator.pop(context),
                            onCancel: () => Navigator.of(context).pop(false),
                          ),
                        );

                        if (confirm == true) {
                          _deleteNotification(context, notification.id);
                        }
                      },
                      backgroundColor: AppColor.turquoise900,
                      foregroundColor: Colors.red,
                      autoClose: true,
                      flex: 1,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete_outline,
                              color: Colors.red, size: 28),
                        ],
                      ),
                    ),
                  ],
                ),
                child: NotificationItem(
                  notification: notification,
                  onTap: () => onNotificationTap(notification),
                  onDelete: () => _deleteNotification(context, notification.id),
                  isActive: notification.isActive,
                  isOdd: index % 2 != 0,
                ),
              );
            },
          );
        }

        if (state is NotificationActionFailed) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: AppColor.oslo400,
                ),
                const SizedBox(height: 16),
                Text(
                  'Đã xảy ra lỗi',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.oslo400,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  state.error,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.oslo400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<NotificationBloc>().add(LoadNotifications());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.turquoise500,
                  ),
                  child: const Text('Thử lại'),
                ),
              ],
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            color: AppColor.turquoise500,
          ),
        );
      },
    );
  }

  void _deleteNotification(BuildContext context, String id) {
    context.read<NotificationBloc>().add(DeleteNotification(id));
  }
}
