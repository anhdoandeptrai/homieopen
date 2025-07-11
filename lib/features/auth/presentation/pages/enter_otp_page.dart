import 'package:app_homieopen_3047/common/helpers/format_phone.dart';
import 'package:app_homieopen_3047/common/helpers/show_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../forms/enter_otp_form.dart';
import '../widgets/auth_appbar.dart';

class EnterOtpPage extends StatefulWidget {
  const EnterOtpPage({super.key, required this.phone, this.isSignup = false});
  final String phone;
  final bool isSignup;
  static route({required String phone, bool isSignup = false}) =>
      MaterialPageRoute(
          builder: (context) => EnterOtpPage(
                phone: phone,
                isSignup: isSignup,
              ));
  @override
  State<EnterOtpPage> createState() => _EnterOtpPageState();
}

class _EnterOtpPageState extends State<EnterOtpPage> {
  void _onBack(BuildContext context) {
    showAlertDialog(
      context,
      () {
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
        title: "Xác minh tài khoản",
        onBack: () => _onBack(context),
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
                    SizedBox(height: 30.h),
                    Text(
                      "Nhập mã OTP",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Column(
                      spacing: 16.h,
                      children: [
                        Text(
                          "Chúng tôi đã gửi mã OTP qua số điện thoại",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          formatPhoneNumber(widget.phone),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    EnterOtpForm(isSignup: widget.isSignup),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
