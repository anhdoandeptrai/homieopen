import 'package:app_homieopen_3047/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpgradeAccountAlert extends StatelessWidget {
  const UpgradeAccountAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        spacing: 44.h,
        children: [
          Icon(
            Icons.lock,
            size: 108.w,
            color: Colors.white,
          ),
          Text(
            "Vui lòng mua gói để xem tập phim này",
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          CustomButton(
            onTap: () {},
            text: "Đăng ký gói",
            radius: 12.r,
          ),
        ],
      ),
    );
  }
}
