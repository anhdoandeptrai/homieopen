import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EpisodeButton extends StatelessWidget {
  const EpisodeButton({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    //test
    final bool isLock = int.parse(text) > 10;
    final bool isWatch = text == "10";
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: isLock
              ? AppColor.red
              : isWatch
                  ? AppColor.turquoise500
                  : Color(0xff343434),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          spacing: 2.w,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: isLock,
              child: Icon(
                Icons.lock,
                size: 16.w,
                color: Colors.white,
              ),
            ),
            Text(
              text == "0" ? "Trailer" : text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
