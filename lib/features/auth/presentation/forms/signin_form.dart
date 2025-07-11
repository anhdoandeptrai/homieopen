import 'package:app_homieopen_3047/common/cubits/obscure_text_cubit.dart';
import 'package:app_homieopen_3047/common/widgets/custom_button.dart';
import 'package:app_homieopen_3047/common/widgets/custom_textfield.dart';
import 'package:app_homieopen_3047/core/di/injection.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../dashboard/cubits/dashboard_cubit.dart';
import '../../../dashboard/pages/dashboard_page.dart';
import '../../data/params/login_params.dart';
import '../bloc/auth_bloc.dart';
import '../pages/forget_password_page.dart';
import '../widgets/auth_bloc_consumer.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneCon = TextEditingController();
  final _passCon = TextEditingController();
  final _phoneNode = FocusNode();
  final _passNode = FocusNode();

  @override
  void dispose() {
    _phoneCon.dispose();
    _passCon.dispose();
    _phoneNode.dispose();
    _passNode.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthBlocConsumer(
      onSuccess: () {
        Navigator.pushReplacement(context, DashboardPage.route());
        context.read<DashboardCubit>().choosePage(0);
      },
      successText: "Đăng nhập thành công",
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            _phoneField(),
            _passField(),
            _forgetPass(),
            _buttonSignin(),
          ],
        ),
      ),
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
          obscureText: state,
        );
      }),
    );
  }

  Widget _forgetPass() {
    return Align(
      alignment: Alignment.topRight,
      child: InkWell(
        onTap: () => Navigator.push(context, ForgetPasswordPage.route()),
        child: Text("Quên mật khẩu?"),
      ),
    );
  }

  Widget _buttonSignin() {
    return CustomButton(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          FocusScope.of(context).unfocus();
          context.read<AuthBloc>().add(
                LoginEvent(
                  params: LoginParams(
                    phone: _phoneCon.text,
                    password: _passCon.text,
                  ),
                ),
              );
        }
      },
      text: "Đăng nhập",
      radius: 12.r,
    );
  }
}
