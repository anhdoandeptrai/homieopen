import 'package:app_homieopen_3047/common/widgets/check_login.dart';
import 'package:app_homieopen_3047/common/widgets/custom_empty.dart';
import 'package:app_homieopen_3047/core/assets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return CheckLogin(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: ListView(children: [
          CustomEmpty(
            image: AppImage.emptyList,
            text: "Danh sách trống",
            button: "Khám phá",
            icon: Icons.search,
            onPressed: () {},
          ),
        ]),
      ),
    );
  }
}
