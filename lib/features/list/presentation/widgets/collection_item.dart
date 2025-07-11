import 'package:app_homieopen_3047/core/assets/app_image.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../pages/view_collection_page.dart';

class CollectionItem extends StatelessWidget {
  const CollectionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, ViewCollectionPage.route());
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Container(
              color: AppColor.oslo800,
            ),
            Positioned(
              top: -80.w,
              right: -50.w,
              child: Stack(
                children: [
                  Image.asset(
                    AppImage.logo,
                    width: 200.w,
                    height: 200.w,
                  ),
                  Container(
                    width: 200.w,
                    height: 200.w,
                    decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(50.r)),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 16.w,
              right: 16.w,
              left: 16.w,
              child: Text(
                "Tên bộ sưu tập",
                maxLines: 2,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
