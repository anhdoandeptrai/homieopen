import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<void> showLoading(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: AppColor.oslo200.withValues(alpha: 0.5),
    builder: (context) => PopScope(
      canPop: false,
      child: Dialog.fullscreen(
        backgroundColor: Colors.transparent,
        child: Center(
          child: Container(
            width: 140.w,
            height: 140.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: SpinKitWave(
              color: AppColor.turquoise500,
              size: 80.w,
            ),
          ),
        ),
      ),
    ),
  );
}
