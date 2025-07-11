import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {super.key,
      required this.controller,
      this.validator,
      this.hintText = 'Enter',
      this.textInputAction,
      this.keyboardType,
      this.prefixIcon,
      this.suffixIcon,
      this.contentPadding,
      this.obscureText = false,
      this.enabled,
      this.fillColor,
      this.maxLines = 1,
      this.readOnly = false,
      this.inputFormatters,
      this.focusNode,
      this.textAlign = TextAlign.start,
      this.onChanged,
      this.isUnderline = false,
      this.autofocus = false,
      this.underlineColor = AppColor.oslo900,
      this.suffixText,
      this.fontSize,
      this.onFieldSubmitted});

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final bool obscureText;
  final bool? enabled;
  final Color? fillColor;
  final int maxLines;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final void Function(String)? onChanged;
  final bool isUnderline;
  final bool autofocus;
  final Color? underlineColor;
  final String? suffixText;
  final double? fontSize;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: textAlign,
      onChanged: onChanged,
      enabled: enabled,
      focusNode: focusNode,
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      autofocus: autofocus,
      maxLines: maxLines,
      readOnly: readOnly,
      inputFormatters: inputFormatters,
      style: TextStyle(
        fontSize: fontSize ?? 17.sp,
      ),
      cursorColor: AppColor.oslo500,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        suffixText: suffixText,
        filled: true,
        fillColor: fillColor,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        isDense: true,
        hintText: hintText,
        contentPadding: contentPadding,
        border: InputBorder.none,
        enabledBorder: isUnderline
            ? UnderlineInputBorder(
                borderSide:
                    BorderSide(color: underlineColor ?? AppColor.oslo900),
              )
            : null,
        focusedBorder: isUnderline
            ? UnderlineInputBorder(
                borderSide:
                    BorderSide(color: underlineColor ?? AppColor.oslo900),
              )
            : null,
        errorBorder: isUnderline
            ? UnderlineInputBorder(
                borderSide:
                    BorderSide(color: underlineColor ?? AppColor.oslo900),
              )
            : null,
        focusedErrorBorder: isUnderline
            ? UnderlineInputBorder(
                borderSide:
                    BorderSide(color: underlineColor ?? AppColor.oslo900),
              )
            : null,
      ),
    );
  }
}
