import 'package:app_homieopen_3047/common/widgets/page_view_button.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:app_homieopen_3047/features/list/presentation/widgets/add_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubits/change_list_page_cubit.dart';

class AddContentPage extends StatefulWidget {
  const AddContentPage({super.key});
  static route() => MaterialPageRoute(builder: (context) => AddContentPage());
  @override
  State<AddContentPage> createState() => _AddContentPageState();
}

class _AddContentPageState extends State<AddContentPage> {
  final PageController _pageController = PageController();
  final _keys = List.generate(3, (_) => GlobalKey<_AddContentPageState>());

  final List<String> tabs = ['Đang xem', 'Yêu thích'];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final kW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: AppColor.turquoise500,
            size: 22.w,
          ),
        ),
        title: Text(
          "Chọn nội dung",
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ChangeContentPageCubit, int>(
        builder: (context, currentPage) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: PageViewButton(
                  alignment: _getAlignForIndex(currentPage),
                  widthButton: (kW - 32) / 2,
                  pageController: _pageController,
                  tabs: tabs,
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  allowImplicitScrolling: true,
                  onPageChanged: (index) =>
                      context.read<ChangeContentPageCubit>().changePage(index),
                  children: [
                    AddContent(key: _keys[0]),
                    AddContent(key: _keys[1], isFavorite: true),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Alignment _getAlignForIndex(int index) {
    switch (index) {
      case 0:
        return Alignment.centerLeft;
      case 1:
        return Alignment.centerRight;
      default:
        return Alignment.centerLeft;
    }
  }
}
