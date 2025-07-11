import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomEditButton extends StatelessWidget {
  const CustomEditButton({
    super.key,
    this.onPressed,
    required this.text,
    this.isButton2 = false,
  });
  final void Function()? onPressed;
  final String text;
  final bool isButton2;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 7.h,
        ),
        backgroundColor: AppColor.turquoise500.withAlpha(isButton2 ? 50 : 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.r),
        ),
      ),
      child: Text(text,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: isButton2 ? AppColor.turquoise500 : Colors.white,
              )),
    );
  }
}
