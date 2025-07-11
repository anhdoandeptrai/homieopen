import 'package:app_homieopen_3047/common/cubits/is_authorized_cubit.dart';
import 'package:app_homieopen_3047/common/widgets/custom_button.dart';
import 'package:app_homieopen_3047/common/widgets/custom_empty.dart';
import 'package:app_homieopen_3047/common/widgets/header_bottom_sheet.dart';
import 'package:app_homieopen_3047/core/assets/app_image.dart';
import 'package:app_homieopen_3047/core/di/injection.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:app_homieopen_3047/features/home/presentation/cubits/save_collection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../auth/presentation/pages/signin_page.dart';
import '../../../../list/presentation/widgets/create_collection_button.dart';
import '../../cubits/page_manage_cubit.dart';
import 'selected_collection_item.dart';

class CollectionSheet extends StatefulWidget {
  const CollectionSheet({super.key});

  @override
  State<CollectionSheet> createState() => _CollectionSheetState();
}

class _CollectionSheetState extends State<CollectionSheet> {
  List<String> list = ["Phim chiếu rạp", "Phim người lớn"];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SaveCollectionCubit>(),
      child: BlocBuilder<SaveCollectionCubit, SaveCollectionState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderBottomSheet(
                title: "Bộ sưu tập",
                onClose: () {
                  context.read<PageManageCubit>().closeBottomSheet();
                },
              ),
              Expanded(
                child: BlocSelector<IsAuthorizedCubit, bool, bool>(
                  selector: (state) => state,
                  builder: (context, isAuthorized) {
                    if (!isAuthorized) {
                      return Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomEmpty(
                              image: AppImage.notLogin,
                              text: "Vui lòng đăng nhập để sử dụng tính năng",
                              button: "Đăng nhập",
                              onPressed: () =>
                                  Navigator.push(context, SigninPage.route()),
                            ),
                          ],
                        ),
                      );
                    }
                    return Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        children: [
                          CreateCollectionButton(),
                          Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 12.h),
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return SelectedCollectionItem(
                                  onTap: () {},
                                  index: index + 1,
                                  state: false,
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.w),
                color: AppColor.oslo900,
                child: CustomButton(
                  onTap: () {
                    context.read<PageManageCubit>().closeBottomSheet();
                  },
                  state: state.list.isNotEmpty,
                  text: "Lưu",
                  radius: 12.r,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
