import 'package:app_homieopen_3047/common/cubits/countdown_cubit.dart';
import 'package:app_homieopen_3047/common/widgets/custom_button.dart';
import 'package:app_homieopen_3047/common/widgets/custom_textfield.dart';
import 'package:app_homieopen_3047/core/di/injection.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:app_homieopen_3047/features/auth/presentation/pages/reset_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/fade_animation.dart';

class EnterOtpForm extends StatefulWidget {
  const EnterOtpForm({super.key, this.isSignup = false});
  final bool isSignup;

  @override
  State<EnterOtpForm> createState() => _EnterOtpFormState();
}

class _EnterOtpFormState extends State<EnterOtpForm> {
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());

  String? _errorMessage;
  late CountdownCubit _countdownCubit;

  @override
  void initState() {
    _countdownCubit = sl<CountdownCubit>()..startCountdown();
    super.initState();
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    _countdownCubit.cancelCountdown();
    _countdownCubit.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _countdownCubit,
      child: Column(
        spacing: 24.h,
        children: [
          _otpField(),
          _resendButton(),
          _errorText(),
        ],
      ),
    );
  }

  Widget _otpField() => Row(
        spacing: 16.w,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          4,
          (index) => Container(
            width: ScreenUtil().screenWidth * 0.16,
            padding: EdgeInsets.only(bottom: 16.w, left: 16.w, right: 16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: AppColor.turquoise500,
                width: 1.5,
              ),
              color: Colors.black,
            ),
            child: CustomTextfield(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              hintText: "",
              isUnderline: true,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1),
              ],
              underlineColor: Colors.white,
              contentPadding: EdgeInsets.only(top: 28.w),
              fontSize: 30.sp,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  if (index < 3) {
                    _focusNodes[index + 1].requestFocus();
                  } else {
                    _focusNodes[index].unfocus();
                  }
                } else if (index > 0) {
                  _focusNodes[index - 1].requestFocus();
                }

                final code = _controllers.map((c) => c.text).join();
                if (code.length == 4) {
                  // Thực hiện xác thực OTP
                  if (_controllers[0].text == "1" &&
                      _controllers[1].text == "2" &&
                      _controllers[2].text == "3" &&
                      _controllers[3].text == "4") {
                    if (widget.isSignup) {
                    } else {
                      Navigator.push(context, ResetPasswordPage.route());
                    }
                  } else {
                    setState(() {
                      _errorMessage = "Mã không đúng";
                    });
                  }
                }
              },
            ),
          ),
        ),
      );

  Widget _errorText() => Visibility(
        visible: _errorMessage != null,
        child: Text(
          _errorMessage ?? '',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Color(0xffD40B0B),
                fontWeight: FontWeight.w600,
              ),
        ),
      );

  Widget _resendButton() => FadeAnimation(
        child: BlocBuilder<CountdownCubit, String>(
          builder: (context, state) {
            return Visibility(
              visible: context.read<CountdownCubit>().timer != null,
              replacement: CustomButton(
                text: "Gửi lại",
                onTap: () {
                  for (var controller in _controllers) {
                    controller.clear();
                  }
                  _focusNodes[0].requestFocus();
                  context.read<CountdownCubit>().startCountdown();
                  // Thực hiện api gửi lại otp
                  // ...
                },
                radius: 12.r,
              ),
              child: RichText(
                text: TextSpan(
                  text: 'Thời gian còn lại: ',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColor.turquoise500,
                      ),
                  children: [
                    TextSpan(
                      text: state,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
}
