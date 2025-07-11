import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavigatorText extends StatelessWidget {
  const NavigatorText({
    super.key,
    required this.onTap,
    required this.firstText,
    required this.lastText,
  });
  final VoidCallback onTap;
  final String firstText;
  final String lastText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              firstText,
              style: TextStyle(fontSize: 17.sp, color: AppColor.oslo700),
            ),
            GestureDetector(
              onTap: onTap,
              child: Text(
                lastText,
                style: TextStyle(fontSize: 17.sp, color: AppColor.turquoise500),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16.h,
        )
      ],
    );
  }
}
