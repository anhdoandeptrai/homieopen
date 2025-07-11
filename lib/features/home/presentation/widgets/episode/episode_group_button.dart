import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EpisodeGroupButton extends StatelessWidget {
  const EpisodeGroupButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.state,
  });
  final VoidCallback onTap;
  final String text;
  final bool state;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: state ? AppColor.turquoise900 : Colors.black,
          borderRadius: BorderRadius.circular(
            12.r,
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
