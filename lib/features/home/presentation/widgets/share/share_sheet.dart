import 'package:app_homieopen_3047/common/widgets/header_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShareSheet extends StatelessWidget {
  const ShareSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderBottomSheet(
          title: "Chia sẻ",
          onClose: () {
            Navigator.pop(context);
          },
        ),
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            spacing: 16.w,
            children: [
              _shareButton(
                context,
                () {},
                Icons.reply,
                "Chia sẻ lên \nFacebook",
              ),
              _shareButton(
                context,
                () {},
                Icons.reply,
                "Chia sẻ lên \nZalo",
              ),
              _shareButton(
                context,
                () {},
                Icons.content_copy,
                "Sao chép mã\n",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _shareButton(
    BuildContext context,
    VoidCallback onTap,
    IconData icon,
    String text,
  ) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          spacing: 6.h,
          children: [
            Icon(
              icon,
              size: 24.w,
              color: Colors.white,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
