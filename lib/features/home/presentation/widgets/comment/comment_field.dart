import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'comment_field_sheet.dart';

class CommentField extends StatelessWidget {
  const CommentField({
    super.key,
    required this.controller,
    required this.focusNode,
  });
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(150),
      ),
      child: GestureDetector(
        onTap: () async {
          // Mở bottom sheet
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            isDismissible: false,
            enableDrag: false,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return CommentFieldSheet(controller: controller);
            },
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(width: 1.w, color: AppColor.oslo500),
          ),
          child: Row(
            spacing: 8.w,
            children: [
              Expanded(
                child: Text(
                  controller.text.isNotEmpty
                      ? controller.text
                      : "Nhập bình luận",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: AppColor.oslo500),
                ),
              ),
              Visibility(
                visible: controller.text.isNotEmpty,
                child: InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.send,
                    color: AppColor.oslo500,
                    size: 22.w,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
