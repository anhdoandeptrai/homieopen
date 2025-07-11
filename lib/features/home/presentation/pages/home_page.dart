import 'package:app_homieopen_3047/common/widgets/page_view_button.dart';
import 'package:app_homieopen_3047/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubits/page_manage_cubit.dart';
import '../cubits/video_player_cubit.dart';
import '../widgets/video/video_list_page_view.dart';
import 'search/pages/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.isVisible});
  final bool isVisible;
  static route({required bool isVisible}) =>
      MaterialPageRoute(builder: (context) => HomePage(isVisible: isVisible));

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  final PageController _pageController = PageController();
  final List<String> tabs = ['Đề xuất', 'Dài tập', 'Ngắn tập'];
  bool _wasVisible = true;

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.isVisible && _wasVisible) {
      context.read<VideoPlayerCubit>().pauseAll();
    }
    _wasVisible = widget.isVisible;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ModalRoute? route = ModalRoute.of(context);
    if (route != null) {
      routeObserver.subscribe(this, route as PageRoute);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {
    final route = ModalRoute.of(context);
    if (route is PageRoute && route.fullscreenDialog == true) {
      context.read<VideoPlayerCubit>().pauseAll();
    }
  }

  void _onBack(BuildContext context) {
    final cubit = context.read<PageManageCubit>();
    final hasBottomSheet = cubit.state.showBottomSheet;
    if (hasBottomSheet) {
      cubit.closeBottomSheet();
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final kW = MediaQuery.of(context).size.width;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _onBack(context);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: BlocBuilder<PageManageCubit, PageManageState>(
          builder: (context, state) {
            return Stack(
              children: [
                // Page view full screen
                PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  allowImplicitScrolling: true,
                  onPageChanged: (index) =>
                      context.read<PageManageCubit>().changeParentPage(index),
                  children: List.generate(3, (index) {
                    if (index == state.indexParentPage) {
                      return VideoListPageView(mainIndex: index);
                    } else {
                      return const SizedBox();
                    }
                  }),
                ),

                // Tab bar nằm dưới status bar
                Visibility(
                  visible: !state.showBottomSheet,
                  child: Positioned(
                    top: statusBarHeight + 8,
                    left: 12,
                    right: 0,
                    child: Row(
                      children: [
                        // Tab container
                        Expanded(
                          child: PageViewButton(
                            alignment: _getAlignForIndex(state.indexParentPage),
                            widthButton: (kW - 80) / 3,
                            pageController: _pageController,
                            tabs: tabs,
                          ),
                        ),
                        // Search icon
                        GestureDetector(
                          onTap: () {
                            context.read<VideoPlayerCubit>().pauseAll();
                            Navigator.push(context, SearchPage.route());
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            height: 35.h,
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 28.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Swipe horizontally to open Episode list sheet
                Visibility(
                  visible: !state.showBottomSheet,
                  child: Positioned(
                    bottom: 100.h,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      width: ScreenUtil().screenWidth,
                      height: ScreenUtil().screenHeight,
                      child: Listener(
                        behavior: HitTestBehavior.translucent,
                        onPointerMove: (event) {
                          if (event.delta.dx.abs() > event.delta.dy.abs()) {
                            if (event.delta.dx < -10 || event.delta.dx > 10) {
                              context
                                  .read<PageManageCubit>()
                                  .openEpisodesSheet();
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Alignment _getAlignForIndex(int index) {
    switch (index) {
      case 0:
        return Alignment.centerLeft;
      case 1:
        return Alignment.center;
      case 2:
        return Alignment.centerRight;
      default:
        return Alignment.centerLeft;
    }
  }
}
