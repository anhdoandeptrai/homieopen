import 'package:app_homieopen_3047/common/widgets/custom_button.dart';
import 'package:app_homieopen_3047/common/widgets/custom_textfield.dart';
import 'package:app_homieopen_3047/features/auth/presentation/pages/enter_otp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({super.key});

  @override
  State<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneCon = TextEditingController();

  @override
  void dispose() {
    _phoneCon.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          _phoneField(),
          _buttonSignin(),
        ],
      ),
    );
  }

  Widget _phoneField() {
    return CustomTextfield(
      controller: _phoneCon,
      hintText: "Nhập số điện thoại",
      prefixIcon: Icon(
        Icons.phone,
        size: 22.w,
        color: const Color.fromARGB(255, 23, 174, 194),
      ),
      keyboardType: TextInputType.phone,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Vui lòng nhập số điện thoại';
        }
        return null;
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }

  Widget _buttonSignin() {
    return CustomButton(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          FocusScope.of(context).unfocus();
          Navigator.push(context,
              EnterOtpPage.route(phone: _phoneCon.text));
        }
      },
      text: "Tiếp theo",
      radius: 12.r,
    );
  }
}
