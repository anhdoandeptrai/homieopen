import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectedCollectionItem extends StatelessWidget {
  const SelectedCollectionItem({
    super.key,
    required this.onTap,
    required this.state,
    required this.index,
  });
  final VoidCallback onTap;
  final int index;
  final bool state;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        spacing: 4.w,
        children: [
          Visibility(
            visible: state,
            replacement: Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(2.r),
                border: Border.all(
                  color: AppColor.turquoise500,
                  width: 2.w,
                ),
              ),
            ),
            child: Icon(
              Icons.check_box,
              color: AppColor.turquoise500,
              size: 24.w,
            ),
          ),
          Text(
            "Tên bộ sưu tập $index",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
