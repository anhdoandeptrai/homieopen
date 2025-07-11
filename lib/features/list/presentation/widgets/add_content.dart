import 'package:app_homieopen_3047/common/widgets/custom_button.dart';
import 'package:app_homieopen_3047/core/di/injection.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubits/add_content_cubit.dart';
import 'gridview_item.dart';

class AddContent extends StatefulWidget {
  const AddContent({super.key, this.isFavorite = false});
  final bool isFavorite;

  @override
  State<AddContent> createState() => _AddContentState();
}

class _AddContentState extends State<AddContent> {
  List<int> viewingList = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];
  List<int> favoriteList = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AddContentCubit>(),
      child: BlocBuilder<AddContentCubit, AddContentState>(
        builder: (context, state) {
          final cubit = context.read<AddContentCubit>();
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
                  child: GridView.builder(
                    itemCount: widget.isFavorite
                        ? favoriteList.length
                        : viewingList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.w,
                      childAspectRatio: 3 / 5,
                    ),
                    itemBuilder: (context, index) {
                      final isSelected = widget.isFavorite
                          ? state.favoriteList.contains(index)
                          : state.viewingList.contains(index);
                      return GridviewItem(
                        onchecked: () {
                          if (widget.isFavorite) {
                            cubit.toggleFavoriteSelection(index);
                          } else {
                            cubit.toggleViewingSelection(index);
                          }
                        },
                        state: isSelected,
                        isEdit: true,
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.w),
                color: AppColor.oslo900,
                child: CustomButton(
                  onTap: () {},
                  text: widget.isFavorite
                      ? state.favoriteList.isNotEmpty
                          ? "Thêm nội dung (${state.favoriteList.length})"
                          : "Thêm nội dung"
                      : state.viewingList.isNotEmpty
                          ? "Thêm nội dung (${state.viewingList.length})"
                          : "Thêm nội dung",
                  radius: 12.r,
                  state: widget.isFavorite
                      ? state.favoriteList.isNotEmpty
                      : state.viewingList.isNotEmpty,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
