import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomEmpty extends StatelessWidget {
  const CustomEmpty({
    super.key,
    required this.image,
    required this.text,
    required this.button,
    this.icon,
    this.onPressed,
  });
  final String image;
  final String text;
  final String button;
  final IconData? icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20.h,
      children: [
        Image.asset(
          image,
          width: ScreenUtil().screenWidth * 0.5,
          height: ScreenUtil().screenWidth * 0.5,
          fit: BoxFit.cover,
        ),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.turquoise500,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            fixedSize: Size(200.w, 55.h),
          ),
          child: Row(
            spacing: 4.w,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: icon != null,
                child: Icon(
                  icon,
                  size: 20.w,
                  color: Colors.white,
                ),
              ),
              Text(
                button,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
