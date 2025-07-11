import 'package:app_homieopen_3047/common/helpers/show_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../forms/reset_password_form.dart';
import '../widgets/auth_appbar.dart';
import '../widgets/auth_logo_and_name.dart';
import '../widgets/navigator_text.dart';
import 'signin_page.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});
  static route() =>
      MaterialPageRoute(builder: (context) => const ResetPasswordPage());
  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  void _onBack(BuildContext context) {
    showAlertDialog(
      context,
      () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
      () {},
      "Thông báo",
      'Bạn chắc chắn muốn thoát?',
      "Đồng ý",
      "Ở lại",
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _onBack(context);
        }
      },
      child: AuthAppbar(
        title: "Đặt lại mật khẩu",
        onBack: () => _onBack(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  spacing: 24.h,
                  children: [
                    AuthLogoAndName(text: "Đặt lại mật khẩu tài khoản"),
                    ResetPasswordForm(),
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
      ),
    );
  }
}
