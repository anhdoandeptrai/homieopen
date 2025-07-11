import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:app_homieopen_3047/features/home/presentation/widgets/episode/episode_button.dart';
import 'package:app_homieopen_3047/features/home/presentation/widgets/episode/episode_group_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubits/page_manage_cubit.dart';
import '../../../../../common/widgets/header_bottom_sheet.dart';

class EpisodeListSheet extends StatefulWidget {
  const EpisodeListSheet({super.key});

  @override
  State<EpisodeListSheet> createState() => _EpisodeListSheetState();
}

class _EpisodeListSheetState extends State<EpisodeListSheet> {
  final List<String> list = [
    "01 - 50",
    "51 - 100",
    "101 - 150",
    "151 - 200",
    "201 - 250",
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderBottomSheet(
          title: "Danh sách tập",
          onClose: () {
            context.read<PageManageCubit>().closeBottomSheet();
          },
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16.h,
                    children: [
                      Text(
                        "Cô dâu 8 tuổi",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Thể loại: Kinh dị",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: AppColor.oslo600),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50.h,
                  margin: EdgeInsets.only(bottom: 16.h),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: list.length,
                    separatorBuilder: (contex, index) => SizedBox(width: 16.w),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: index == 0 ? 16.w : 0,
                            right: index == list.length - 1 ? 16.w : 0),
                        child: EpisodeGroupButton(
                          onTap: () {},
                          text: list[index],
                          state: index == 0 ? true : false,
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    // spacing: 10.h,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 6.w,
                            children: [
                              Text(
                                "Sắp xếp",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Icon(
                                Icons.layers,
                                size: 20.w,
                                color: AppColor.oslo600,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 51,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 12.w,
                          crossAxisSpacing: 12.w,
                          childAspectRatio: 4 / 2,
                        ),
                        itemBuilder: (context, index) {
                          return EpisodeButton(
                            text: "$index",
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
