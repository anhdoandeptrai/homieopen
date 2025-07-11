import 'package:app_homieopen_3047/core/assets/app_vectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthGoogleLogin extends StatelessWidget {
  const AuthGoogleLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SvgPicture.asset(
        AppVector.googleLogin,
        height: 50.w,
        width: 50.w,
      ),
    );
  }
}
