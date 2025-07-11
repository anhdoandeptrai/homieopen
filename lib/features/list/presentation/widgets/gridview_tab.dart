import 'package:app_homieopen_3047/common/helpers/show_alert_dialog.dart';
import 'package:app_homieopen_3047/common/widgets/custom_button.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:app_homieopen_3047/features/list/presentation/cubits/delete_video_item_cubit.dart';
import 'package:app_homieopen_3047/features/list/presentation/pages/add_content_page.dart';
import 'package:app_homieopen_3047/features/list/presentation/widgets/custom_edit_button.dart';
import 'package:app_homieopen_3047/features/list/presentation/widgets/gridview_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridviewTab extends StatefulWidget {
  const GridviewTab({super.key, this.isViewCollection = false});
  final bool isViewCollection;

  @override
  State<GridviewTab> createState() => _GridviewTabState();
}

class _GridviewTabState extends State<GridviewTab> {
  List<int> list = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeleteVideoItemCubit, DeleteVideoItemState>(
      builder: (context, state) {
        final cubit = context.read<DeleteVideoItemCubit>();
        final isAll = cubit.isAllSelected(list);
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
              child: Column(
                spacing: 16.h,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: state.list.isNotEmpty,
                        replacement: widget.isViewCollection
                            ? Text("${list.length} video",
                                style: Theme.of(context).textTheme.bodyMedium)
                            : SizedBox(),
                        child: Text("${state.list.length} đã chọn",
                            style: Theme.of(context).textTheme.bodyMedium),
                      ),
                      Row(
                        spacing: 10.w,
                        children: [
                          CustomEditButton(
                            onPressed: () {
                              if (state.isEdit) {
                                cubit.selectAllOrClear(list);
                              } else {
                                cubit.startEdit();
                              }
                            },
                            text: state.isEdit
                                ? isAll
                                    ? "Bỏ chọn tất cả"
                                    : "Chọn tất cả"
                                : "Chỉnh sửa",
                            isButton2: widget.isViewCollection && !state.isEdit
                                ? true
                                : false,
                          ),
                          Visibility(
                            visible: widget.isViewCollection && !state.isEdit,
                            child: CustomEditButton(
                              onPressed: () => Navigator.push(
                                  context, AddContentPage.route()),
                              text: "Thêm",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: list.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.w,
                        childAspectRatio: 3 / 5,
                      ),
                      itemBuilder: (context, index) {
                        final isSelected = state.list.contains(index);
                        return GridviewItem(
                          onchecked: () {
                            cubit.toggleSelection(index);
                          },
                          state: isSelected,
                          isEdit: state.isEdit,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Visibility(
                visible: state.isEdit,
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  color: Colors.black,
                  child: Row(
                    spacing: 16.w,
                    children: [
                      Expanded(
                        child: CustomButton(
                          onTap: () {
                            showAlertDialog(
                              context,
                              () {
                                context.read<DeleteVideoItemCubit>().stopEdit();
                              },
                              () {},
                              "Xóa video đang xem",
                              "Bạn có đồng ý xóa các video đã chọn?",
                              "Đồng ý",
                              "Hủy",
                            );
                          },
                          text: "Xóa",
                          radius: 12.r,
                          color: AppColor.red,
                          state: state.list.isNotEmpty,
                        ),
                      ),
                      Expanded(
                        child: CustomButton(
                          onTap: () {
                            context.read<DeleteVideoItemCubit>().stopEdit();
                          },
                          text: "Hủy",
                          radius: 12.r,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
