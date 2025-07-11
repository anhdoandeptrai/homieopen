import 'package:app_homieopen_3047/core/assets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthLogoAndName extends StatelessWidget {
  const AuthLogoAndName({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 24.h,
        children: [
          SizedBox(
            height: 30.h,
          ),
          Image.asset(
            AppImage.logo,
            width: 120.w,
            height: 120.w,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
