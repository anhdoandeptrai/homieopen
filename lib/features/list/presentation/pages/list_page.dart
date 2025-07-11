import 'package:app_homieopen_3047/common/widgets/page_view_button.dart';
import 'package:app_homieopen_3047/common/widgets/search_field.dart';
import 'package:app_homieopen_3047/features/list/presentation/cubits/delete_video_item_cubit.dart';
import 'package:app_homieopen_3047/features/list/presentation/widgets/gridview_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubits/change_list_page_cubit.dart';
import '../widgets/collection_tab.dart';
import '../widgets/empty_list.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final _searchController = TextEditingController();
  final _searchNode = FocusNode();
  final PageController _pageController = PageController();
  final _keys = List.generate(3, (_) => GlobalKey<_ListPageState>());

  final List<String> tabs = ['Đang xem', 'Yêu thích', 'Bộ sưu tập'];

  @override
  void dispose() {
    _searchController.dispose();
    _pageController.dispose();
    _searchNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final kW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Danh sách",
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 12.h),
        child: BlocBuilder<ChangeListPageCubit, int>(
          builder: (context, currentPage) {
            return BlocBuilder<DeleteVideoItemCubit, DeleteVideoItemState>(
              builder: (context, state) {
                return Column(
                  spacing: 12.h,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        spacing: 12.h,
                        children: [
                          SearchField(
                            controller: _searchController,
                            focusNode: _searchNode,
                          ),
                          PageViewButton(
                            alignment: _getAlignForIndex(currentPage),
                            widthButton: (kW - 32) / 3,
                            pageController: _pageController,
                            tabs: tabs,
                            state: !state.isEdit,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        physics: state.isEdit
                            ? NeverScrollableScrollPhysics()
                            : AlwaysScrollableScrollPhysics(),
                        allowImplicitScrolling: true,
                        onPageChanged: (index) => context
                            .read<ChangeListPageCubit>()
                            .changePage(index),
                        children: [
                          GridviewTab(key: _keys[0]),
                          EmptyList(key: _keys[1]),
                          CollectionTab(key: _keys[2]),
                        ],
                      ),
                    ),
                  ],
                );
              },
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
