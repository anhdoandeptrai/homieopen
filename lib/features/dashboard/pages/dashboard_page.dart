import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:app_homieopen_3047/common/cubits/is_authorized_cubit.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:app_homieopen_3047/features/list/presentation/cubits/delete_video_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../home/presentation/cubits/page_manage_cubit.dart';
import '../cubits/dashboard_cubit.dart';
import '../cubits/notification_count_cubit.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  static route() => MaterialPageRoute(builder: (context) => DashboardPage());

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  @override
  void initState() {
    super.initState();
    context.read<IsAuthorizedCubit>().isAuthorized();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeleteVideoItemCubit, DeleteVideoItemState>(
      builder: (context, stateDel) {
        return BlocBuilder<PageManageCubit, PageManageState>(
          builder: (context, stateVideo) {
            return BlocBuilder<DashboardCubit, int>(
              builder: (context, state) => Scaffold(
                body: IndexedStack(
                  index: state,
                  children: context.read<DashboardCubit>().getPages(state),
                ),
                bottomNavigationBar: stateVideo.showBottomSheet ||
                        stateDel.isEdit
                    ? SizedBox()
                    : AnimatedBottomNavigationBar.builder(
                        backgroundColor: Colors.black,
                        itemCount: context.read<DashboardCubit>().icons.length,
                        tabBuilder: (index, isActive) {
                          final icon =
                              context.read<DashboardCubit>().icons[index];
                          final color = isActive
                              ? AppColor.turquoise500
                              : AppColor.oslo600;

                          if (index == 2) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 4.h,
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Center(
                                        child: Icon(icon,
                                            size: 24.w, color: color)),
                                    BlocBuilder<NotificationCountCubit, int>(
                                      builder: (context, count) {
                                        if (count > 0) {
                                          return Positioned(
                                            top: -2.h,
                                            right: 7.w,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 1.h,
                                                  horizontal: 30.w),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              child: Text(
                                                count < 100 ? '$count' : '99+',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        return SizedBox.shrink();
                                      },
                                    ),
                                  ],
                                ),
                                Text(
                                  context.read<DashboardCubit>().text[index],
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: color,
                                    fontWeight: isActive
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            );
                          }

                          // Các icon khác
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 4.h,
                            children: [
                              Icon(icon, size: 24.w, color: color),
                              Text(
                                context.read<DashboardCubit>().text[index],
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: color,
                                  fontWeight: isActive
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          );
                        },
                        activeIndex: state,
                        gapLocation: GapLocation.none,
                        notchSmoothness: NotchSmoothness.verySmoothEdge,
                        onTap: (index) {
                          context.read<DashboardCubit>().choosePage(index);
                          if (index == 2) {
                            context.read<NotificationCountCubit>().reset();
                          }
                        },
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
