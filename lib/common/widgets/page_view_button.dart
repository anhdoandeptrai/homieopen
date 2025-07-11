import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageViewButton extends StatelessWidget {
  const PageViewButton({
    super.key,
    required this.alignment,
    required this.widthButton,
    required this.pageController,
    required this.tabs,
    this.state = true,
  });
  final AlignmentGeometry alignment;
  final double widthButton;
  final PageController pageController;
  final List<String> tabs;
  final bool state;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: Color(0xff7E8384).withAlpha(70),
        borderRadius: BorderRadius.circular(9.r),
      ),
      child: Stack(
        children: [
          // Animated tab highlight (màu xanh)
          AnimatedAlign(
            alignment: alignment,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Container(
              width: widthButton,
              padding: EdgeInsets.symmetric(vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColor.turquoise500,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
          // Tab texts
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(tabs.length, (index) {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (state) {
                      pageController.animateToPage(
                        index,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
                  },
                  child: Container(
                    width: widthButton,
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
