import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthDividerOr extends StatelessWidget {
  const AuthDividerOr({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Row(
        spacing: 16.w,
        children: [
          Expanded(
            child: Divider(
              height: 1.h,
              color: AppColor.oslo700,
            ),
          ),
          Text(
            "Hoặc",
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: AppColor.oslo700),
          ),
          Expanded(
            child: Divider(
              height: 1.h,
              color: AppColor.oslo700,
            ),
          ),
        ],
      ),
    );
  }
}
