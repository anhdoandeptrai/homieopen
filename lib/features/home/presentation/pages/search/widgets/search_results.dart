import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../list/presentation/widgets/gridview_item.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key, required this.keyword});
  final String keyword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        spacing: 16.w,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "10 kết quả tìm kiếm cho \"$keyword\"",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColor.oslo700),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 15,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.w,
                childAspectRatio: 3 / 5,
              ),
              itemBuilder: (context, index) {
                return GridviewItem();
              },
            ),
          ),
        ],
      ),
    );
  }
}
