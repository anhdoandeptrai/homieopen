import 'package:app_homieopen_3047/features/auth/presentation/pages/signup_page.dart';
import 'package:app_homieopen_3047/features/auth/presentation/widgets/auth_appbar.dart';
import 'package:app_homieopen_3047/features/auth/presentation/widgets/auth_divider_or.dart';
import 'package:app_homieopen_3047/features/auth/presentation/widgets/auth_google_login.dart';
import 'package:app_homieopen_3047/features/auth/presentation/widgets/auth_logo_and_name.dart';
import 'package:app_homieopen_3047/features/auth/presentation/widgets/navigator_text.dart';
import 'package:app_homieopen_3047/features/auth/presentation/forms/signin_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});
  static route() => MaterialPageRoute(builder: (context) => const SigninPage());

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return AuthAppbar(
      title: "Đăng nhập",
      isBack: false,
      state: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                spacing: 24.h,
                children: [
                  AuthLogoAndName(text: "Đăng nhập"),
                  SigninForm(),
                  AuthDividerOr(),
                  AuthGoogleLogin(),
                ],
              ),
            ),
          ),
          NavigatorText(
            onTap: () => Navigator.push(context, SignupPage.route()),
            firstText: "Chưa có tài khoản? ",
            lastText: "Đăng ký",
          ),
        ],
      ),
    );
  }
}
