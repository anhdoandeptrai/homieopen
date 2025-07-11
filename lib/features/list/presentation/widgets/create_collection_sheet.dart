import 'package:app_homieopen_3047/common/widgets/custom_button.dart';
import 'package:app_homieopen_3047/common/widgets/custom_textfield.dart';
import 'package:app_homieopen_3047/common/widgets/header_bottom_sheet.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubits/dynamic_text_field_cubit.dart';

class CreateCollectionSheet extends StatelessWidget {
  const CreateCollectionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final keyboardPadding = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: keyboardPadding),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: ScreenUtil().screenHeight -
              MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(
          color: AppColor.oslo800,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HeaderBottomSheet(
              title: "Bộ sưu tập mới",
              onClose: () => Navigator.pop(context),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                spacing: 16.h,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12.h,
                    children: [
                      Text(
                        "Tên bộ sưu tập",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      BlocBuilder<DynamicTextFieldCubit,
                          List<TextEditingController>>(
                        builder: (context, controllers) {
                          return LayoutBuilder(builder: (context, constraints) {
                            final maxHeight = ScreenUtil().screenHeight * 0.5 -
                                MediaQuery.of(context).viewInsets.bottom;
                            final itemHeight = 60.h + 12.h;
                            final totalHeight = controllers.length * itemHeight;
                            return ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: totalHeight > maxHeight
                                    ? maxHeight
                                    : double.infinity,
                              ),
                              child: ListView.separated(
                                itemCount: controllers.length,
                                shrinkWrap: true,
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 12.h),
                                itemBuilder: (context, index) {
                                  return CustomTextfield(
                                      controller: controllers[index],
                                      hintText: "Nhập tên bộ sưu tập",
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          context
                                              .read<DynamicTextFieldCubit>()
                                              .removeTextField(index);
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          size: 22.w,
                                          color: AppColor.oslo700,
                                        ),
                                      ));
                                },
                              ),
                            );
                          });
                        },
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () =>
                        context.read<DynamicTextFieldCubit>().addTextField(),
                    child: Row(
                      spacing: 4.w,
                      children: [
                        Icon(
                          Icons.add,
                          size: 20.w,
                          color: AppColor.turquoise500,
                        ),
                        Text(
                          "Thêm bộ sưu tập",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColor.turquoise500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.w),
              color: AppColor.oslo900,
              child: CustomButton(
                onTap: () {
                  Navigator.pop(context);
                },
                text: "Lưu",
                radius: 12.r,
              ),
            )
          ],
        ),
      ),
    );
  }
}
