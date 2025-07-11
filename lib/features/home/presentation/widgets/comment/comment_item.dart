import 'package:app_homieopen_3047/common/widgets/custom_image_network.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.w,
        children: [
          ClipOval(
            child: CustomImageNetwork(
              image: "",
              width: 32.w,
              height: 32.w,
              isAvatar: true,
            ),
          ),
          Column(
            spacing: 8.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nguyễn Văn A",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: AppColor.oslo600),
              ),
              Text(
                "Nội dung bình luận",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                "10 ngày",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: AppColor.oslo600),
              ),
            ],
          )
        ],
      ),
    );
  }
}
