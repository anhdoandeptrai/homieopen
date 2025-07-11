import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/auth_appbar.dart';
import '../widgets/auth_divider_or.dart';
import '../widgets/auth_google_login.dart';
import '../widgets/auth_logo_and_name.dart';
import '../widgets/navigator_text.dart';
import '../forms/signup_form.dart';
import 'signin_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  static route() => MaterialPageRoute(builder: (context) => const SignupPage());
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return AuthAppbar(
      title: "Đăng ký",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                spacing: 24.h,
                children: [
                  AuthLogoAndName(text: "Đăng ký tài khoản"),
                  SignupForm(),
                  AuthDividerOr(),
                  AuthGoogleLogin(),
                ],
              ),
            ),
          ),
          NavigatorText(
            onTap: () => Navigator.push(context, SigninPage.route()),
            firstText: "Đã có tài khoản? ",
            lastText: "Đăng nhập",
          ),
        ],
      ),
    );
  }
}
