import 'package:flutter/material.dart';
import '../../../../core/utils/theme/app_color.dart';
import '../../models/notification_model.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  final bool isActive;
  final bool isOdd;

  const NotificationItem({
    super.key,
    required this.notification,
    required this.onTap,
    this.onDelete,
    this.isActive = false,
    this.isOdd = false,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = notification.isRead
        ? AppColor.oslo950
        : isOdd
            ? AppColor.turquoise950
            : AppColor.turquoise950;

    final iconBackgroundColor = notification.isRead
        ? Colors.black
        : isOdd
            ? Colors.black
            : Colors.black;

    final textColor = notification.isRead ? Colors.white : Colors.white;

    final subtitleColor = notification.isRead
        ? Colors.white.withOpacity(0.5)
        : Colors.white.withOpacity(0.5);

    return InkWell(
      onTap: onTap,
      child: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Icon(
                    notification.isRead
                        ? Icons.notifications_rounded
                        : Icons.notifications_active,
                    color: notification.isRead
                        ? AppColor.turquoise500
                        : AppColor.turquoise500,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: notification.isRead
                            ? FontWeight.normal
                            : FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.message,
                      style: TextStyle(
                        fontSize: 14,
                        color: subtitleColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _formatTimestamp(notification.timestamp),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    String hour = timestamp.hour.toString().padLeft(2, '0');
    String minute = timestamp.minute.toString().padLeft(2, '0');
    String day = timestamp.day.toString().padLeft(2, '0');
    String month = timestamp.month.toString().padLeft(2, '0');
    String year = timestamp.year.toString();

    return '$hour:$minute $day/$month/$year';
  }
}
