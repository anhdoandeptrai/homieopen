import 'package:flutter/material.dart';
import 'presentation/pages/notification_detail_page.dart';
import 'presentation/pages/notification_list_page.dart';

class NotificationModule {
  static Map<String, WidgetBuilder> routes() {
    return {
      '/notifications': (context) => const NotificationListPage(),
      '/notification/detail': (context) {
        final args = ModalRoute.of(context)!.settings.arguments as String;
        return NotificationDetailPage(notificationId: args);
      },
    };
  }
}
