import 'package:app_homieopen_3047/common/cubits/obscure_text_cubit.dart';
import 'package:app_homieopen_3047/common/widgets/custom_button.dart';
import 'package:app_homieopen_3047/common/widgets/custom_textfield.dart';
import 'package:app_homieopen_3047/core/di/injection.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _passCon = TextEditingController();
  final _confirmPassCon = TextEditingController();
  final _confirmPassNode = FocusNode();

  @override
  void dispose() {
    _passCon.dispose();
    _confirmPassCon.dispose();
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
          _passField(),
          _confirmPassField(),
          _buttonResetPass(),
        ],
      ),
    );
  }

  Widget _passField() {
    return BlocProvider(
      create: (context) => sl<ObscureTextCubit>(),
      child: BlocBuilder<ObscureTextCubit, bool>(builder: (context, state) {
        return CustomTextfield(
          controller: _passCon,
          hintText: "Nhập mật khẩu mới",
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
              return 'Vui lòng nhập mật khẩu mới';
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
          hintText: "Nhập lại mật khẩu mới",
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
              return 'Vui lòng xác nhận mật khẩu mới';
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

  Widget _buttonResetPass() {
    return CustomButton(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          FocusScope.of(context).unfocus();
        }
      },
      text: "Đặt lại mật khẩu",
      radius: 12.r,
    );
  }
}
