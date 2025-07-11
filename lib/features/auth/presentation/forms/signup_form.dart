import 'package:app_homieopen_3047/common/cubits/obscure_text_cubit.dart';
import 'package:app_homieopen_3047/common/widgets/custom_button.dart';
import 'package:app_homieopen_3047/common/widgets/custom_textfield.dart';
import 'package:app_homieopen_3047/core/di/injection.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:app_homieopen_3047/features/auth/presentation/pages/enter_otp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameCon = TextEditingController();
  final _lastNameCon = TextEditingController();
  final _phoneCon = TextEditingController();
  final _passCon = TextEditingController();
  final _confirmPassCon = TextEditingController();
  final _lastNameNode = FocusNode();
  final _phoneNode = FocusNode();
  final _passNode = FocusNode();
  final _confirmPassNode = FocusNode();

  @override
  void dispose() {
    _firstNameCon.dispose();
    _lastNameCon.dispose();
    _phoneCon.dispose();
    _passCon.dispose();
    _confirmPassCon.dispose();
    _lastNameNode.dispose();
    _phoneNode.dispose();
    _passNode.dispose();
    _confirmPassNode.dispose();
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
          Row(
            spacing: 12.w,
            children: [
              Expanded(
                child: _firstNameField(),
              ),
              Expanded(
                child: _lastNameField(),
              ),
            ],
          ),
          _phoneField(),
          _passField(),
          _confirmPassField(),
          _buttonSignup(),
        ],
      ),
    );
  }

  Widget _firstNameField() {
    return CustomTextfield(
      controller: _firstNameCon,
      hintText: "Họ & tên đệm",
      prefixIcon: Icon(
        Icons.person,
        size: 22.w,
        color: const Color.fromARGB(255, 23, 174, 194),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Không được rỗng';
        }
        return null;
      },
      onFieldSubmitted: (_) =>
          FocusScope.of(context).requestFocus(_lastNameNode),
    );
  }

  Widget _lastNameField() {
    return CustomTextfield(
      controller: _lastNameCon,
      focusNode: _lastNameNode,
      hintText: "Tên",
      prefixIcon: Icon(
        Icons.account_circle,
        size: 22.w,
        color: const Color.fromARGB(255, 23, 174, 194),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Không được rỗng';
        }
        return null;
      },
      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_phoneNode),
    );
  }

  Widget _phoneField() {
    return CustomTextfield(
      controller: _phoneCon,
      focusNode: _phoneNode,
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
        } else if (val.length < 10) {
          return "Số điện thoại ít nhất có 10 chữ số";
        }
        return null;
      },
      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_passNode),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }

  Widget _passField() {
    return BlocProvider(
      create: (context) => sl<ObscureTextCubit>(),
      child: BlocBuilder<ObscureTextCubit, bool>(builder: (context, state) {
        return CustomTextfield(
          controller: _passCon,
          focusNode: _passNode,
          hintText: "Nhập mật khẩu",
          prefixIcon: Icon(
            Icons.password,
            size: 22.w,
            color: AppColor.turquoise500,
          ),
          suffixIcon: InkWell(
            onTap: () => context.read<ObscureTextCubit>().toggleObscureText(),
            child: Icon(
              state ? Icons.visibility : Icons.visibility_off,
              size: 22.w,
              color: AppColor.oslo700,
            ),
          ),
          validator: (val) {
            if (val == null || val.isEmpty) {
              return 'Vui lòng nhập mật khẩu';
            }
            return null;
          },
          onFieldSubmitted: (_) =>
              FocusScope.of(context).requestFocus(_confirmPassNode),
          obscureText: state,
        );
      }),
    );
  }

  Widget _confirmPassField() {
    return BlocProvider(
      create: (context) => sl<ObscureTextCubit>(),
      child: BlocBuilder<ObscureTextCubit, bool>(builder: (context, state) {
        return CustomTextfield(
          controller: _confirmPassCon,
          focusNode: _confirmPassNode,
          hintText: "Nhập xác nhận mật khẩu",
          prefixIcon: Icon(
            Icons.password,
            size: 22.w,
            color: AppColor.turquoise500,
          ),
          suffixIcon: InkWell(
            onTap: () => context.read<ObscureTextCubit>().toggleObscureText(),
            child: Icon(
              state ? Icons.visibility : Icons.visibility_off,
              size: 22.w,
              color: AppColor.oslo700,
            ),
          ),
          validator: (val) {
            if (val == null || val.isEmpty) {
              return 'Vui lòng nhập lại mật khẩu';
            } else if (_passCon.text != val) {
              return 'Mật khẩu không khớp';
            }
            return null;
          },
          obscureText: state,
        );
      }),
    );
  }

  Widget _buttonSignup() {
    return CustomButton(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          FocusScope.of(context).unfocus();
          Navigator.push(
            context,
            EnterOtpPage.route(phone: _phoneCon.text, isSignup: true),
          );
        }
      },
      text: "Đăng ký",
      radius: 12.r,
    );
  }
}
