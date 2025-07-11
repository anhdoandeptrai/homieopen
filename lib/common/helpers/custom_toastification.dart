// lib/utils/custom_toastification.dart
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class CustomToastification {
  static void show(
    BuildContext context, {
    required String message,
    ToastificationType type = ToastificationType.info,
    String? title,
    int duration = 3,
    ToastificationStyle style = ToastificationStyle.flatColored,
    Alignment alignment = Alignment.topCenter,
  }) {
    toastification.show(
      context: context,
      title: title != null ? Text(title) : null,
      description: Text(message),
      type: type,
      style: style,
      alignment: alignment,
      autoCloseDuration: Duration(seconds: duration),
      animationDuration: const Duration(milliseconds: 400),
      icon: _iconForType(type),
      borderRadius: BorderRadius.circular(12),
      margin: const EdgeInsets.all(16),
    );
  }

  static Icon? _iconForType(ToastificationType type) {
    switch (type) {
      case ToastificationType.success:
        return const Icon(Icons.check_circle, color: Colors.green);
      case ToastificationType.error:
        return const Icon(Icons.error, color: Colors.red);
      case ToastificationType.warning:
        return const Icon(Icons.warning, color: Colors.orange);
      case ToastificationType.info:
      default:
        return const Icon(Icons.info, color: Colors.blue);
    }
  }

  static void success(BuildContext context, String message, {String? title}) {
    show(context,
        message: message,
        type: ToastificationType.success,
        title: title ?? "Thành công");
  }

  static void error(BuildContext context, String message, {String? title}) {
    show(context,
        message: message,
        type: ToastificationType.error,
        title: title ?? "Lỗi");
  }

  static void warning(BuildContext context, String message, {String? title}) {
    show(context,
        message: message,
        type: ToastificationType.warning,
        title: title ?? "Cảnh báo");
  }

  static void info(BuildContext context, String message, {String? title}) {
    show(context,
        message: message,
        type: ToastificationType.info,
        title: title ?? "Thông tin");
  }
}
