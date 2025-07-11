import 'package:app_homieopen_3047/features/auth/presentation/pages/signin_page.dart';
import 'package:app_homieopen_3047/features/auth/presentation/widgets/auth_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/auth_logo_and_name.dart';
import '../forms/forget_password_form.dart';
import '../widgets/navigator_text.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});
  static route() =>
      MaterialPageRoute(builder: (context) => const ForgetPasswordPage());

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return AuthAppbar(
      title: "Quên mật khẩu",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                spacing: 24.h,
                children: [
                  AuthLogoAndName(text: "Quên mật khẩu tài khoản"),
                  ForgetPasswordForm(),
                ],
              ),
            ),
          ),
          NavigatorText(
            onTap: () => Navigator.push(context, SigninPage.route()),
            firstText: "Đã nhớ tài khoản? ",
            lastText: "Đăng nhập",
          ),
        ],
      ),
    );
  }
}
