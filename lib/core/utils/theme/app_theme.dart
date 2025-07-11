import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_color.dart';

class AppTheme {
  AppTheme._();

  static OutlineInputBorder _inputBorder({
    Color borderColor = AppColor.oslo700,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        12.r,
      ),
      borderSide: BorderSide(
        width: 1.w,
        color: borderColor,
      ),
      gapPadding: 0,
    );
  }

  static final _inputDecoration = InputDecorationTheme(
    fillColor: Colors.black,
    filled: true,
    enabledBorder: _inputBorder(),
    focusedBorder: _inputBorder(
      borderColor: AppColor.turquoise500,
    ),
    errorBorder: _inputBorder(
      borderColor: AppColor.red,
    ),
    focusedErrorBorder: _inputBorder(
      borderColor: AppColor.red,
    ),
    focusColor: AppColor.turquoise500,
    disabledBorder: _inputBorder(borderColor: AppColor.oslo700),
    hintStyle: _textStyle(
      fontSize: 17.sp,
      fontWeight: FontWeight.w400,
      textColor: AppColor.oslo700,
    ),
    errorStyle: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: Colors.red,
    ),
  );

  static TextStyle _textStyle({
    required double fontSize,
    Color? textColor = AppColor.oslo900,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
  }) =>
      TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
        letterSpacing: letterSpacing,
      );

  // * Cấu hình chữ cho App
  static final TextTheme _appTextTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 57.sp),
    displayMedium: TextStyle(fontSize: 45.sp),
    displaySmall: TextStyle(fontSize: 36.sp),
    headlineLarge: TextStyle(fontSize: 32.sp),
    headlineMedium: TextStyle(fontSize: 28.sp),
    headlineSmall: TextStyle(fontSize: 24.sp),
    titleLarge: TextStyle(fontSize: 22.sp),
    titleMedium: TextStyle(fontSize: 20.sp),
    titleSmall: TextStyle(fontSize: 17.sp),
    bodyLarge: TextStyle(fontSize: 16.sp),
    bodyMedium: TextStyle(fontSize: 15.sp),
    bodySmall: TextStyle(fontSize: 14.sp),
    labelLarge: TextStyle(fontSize: 13.sp),
    labelMedium: TextStyle(fontSize: 12.sp),
    labelSmall: TextStyle(fontSize: 10.sp),
  ).apply(
    bodyColor: Colors.white,
  );

  // * Cấu hình chọn date cho App
  static final DatePickerThemeData _datePickerTheme = DatePickerThemeData(
    dividerColor: AppColor.oslo800,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.w),
    ),
    dayStyle: TextStyle(
      fontSize: 16.sp,
      color: AppColor.oslo900,
    ),
    todayForegroundColor: WidgetStatePropertyAll(AppColor.turquoise500),
    todayBorder: BorderSide.none,
    cancelButtonStyle: TextButton.styleFrom(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColor.red,
    ),
    confirmButtonStyle: ElevatedButton.styleFrom(
      backgroundColor: AppColor.turquoise500,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.w),
      ),
    ),
  );

  // * Cấu hình theme cho App
  static final appTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.oslo900, // Màu nền AppBar cho dark mode
      titleTextStyle: _textStyle(
        fontSize: 17.sp,
        fontWeight: FontWeight.w400,
        height: 24 / 14,
        letterSpacing: 0.5,
        textColor: Colors.white,
      ),
    ),
    cupertinoOverrideTheme: CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.grey,
    ),
    scaffoldBackgroundColor: AppColor.oslo900,
    fontFamily: 'Inter',
    dividerColor: AppColor.oslo200,
    primaryColor: AppColor.turquoise500,
    primaryTextTheme: _appTextTheme,
    datePickerTheme: _datePickerTheme,
    inputDecorationTheme: _inputDecoration,
    textTheme: _appTextTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.turquoise500,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
