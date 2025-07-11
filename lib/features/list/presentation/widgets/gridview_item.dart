import 'package:app_homieopen_3047/common/widgets/custom_image_network.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridviewItem extends StatelessWidget {
  const GridviewItem({
    super.key,
    this.onchecked,
    this.state = false,
    this.isEdit = false,
  });

  final VoidCallback? onchecked;
  final bool state;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEdit ? onchecked : () {},
      child: AspectRatio(
        aspectRatio: 3 / 5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox.expand(
                  child: Stack(
                    children: [
                      CustomImageNetwork(
                        image:
                            "https://m.media-amazon.com/images/I/71xefrbhS8S._AC_SL1500_.jpg",
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      if (isEdit)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Padding(
                            padding: EdgeInsets.all(6.w),
                            child: Container(
                              width: 20.w,
                              height: 20.w,
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: AppColor.turquoise500,
                                  width: 2.w,
                                ),
                              ),
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: state
                                      ? AppColor.turquoise500
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  color: state ? Colors.black : AppColor.oslo700,
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4.h,
                    children: [
                      SizedBox(
                        height: 30.h,
                        child: Text(
                          'Film Name',
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      Text(
                        'Tập 1',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
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
