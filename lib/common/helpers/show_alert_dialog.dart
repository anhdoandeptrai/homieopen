import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/cupertino.dart';

showAlertDialog(
    BuildContext context,
    VoidCallback onPressed,
    VoidCallback? onCancel,
    String title,
    String content,
    String titleButton,
    String? titleCancel) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(
          content,
        ),
        actions: <CupertinoDialogAction>[
          if (onCancel != null)
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                onCancel();
                Navigator.of(context).pop();
              },
              child: Text(
                titleCancel ?? "Hủy",
                style: TextStyle(
                    color: AppColor.turquoise500, fontWeight: FontWeight.w400),
              ),
            ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(context).pop();
              onPressed();
            },
            child: Text(
              titleButton,
              style: TextStyle(
                color: AppColor.turquoise500,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
    },
  );
}
