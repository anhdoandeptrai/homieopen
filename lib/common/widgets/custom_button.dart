import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color? color;
  final Color? textColor;
  final double radius;
  final double? fontSize;
  final double height;
  final double width;
  final IconData? prefixIcon;
  final Color? iconColor;
  final bool? state;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.color,
    this.textColor,
    required this.radius,
    this.fontSize,
    this.height = 55,
    this.width = 395,
    this.prefixIcon,
    this.iconColor,
    this.state = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: state! ? color ?? AppColor.turquoise500 : AppColor.oslo600,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: ElevatedButton(
        onPressed: state!
            ? () {
                onTap();
              }
            : null,
        style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          fixedSize: Size(width, height),
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
        ),
        child: Visibility(
          visible: prefixIcon != null && iconColor != null,
          replacement: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
              color: state! ? textColor ?? Colors.white : AppColor.oslo400,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8.w,
            children: [
              Icon(
                prefixIcon,
                color: iconColor,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  color: state! ? textColor ?? Colors.white : AppColor.oslo400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
