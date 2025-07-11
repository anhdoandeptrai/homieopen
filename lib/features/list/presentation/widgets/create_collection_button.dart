import 'package:app_homieopen_3047/core/di/injection.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubits/dynamic_text_field_cubit.dart';
import 'create_collection_sheet.dart';

class CreateCollectionButton extends StatelessWidget {
  const CreateCollectionButton({super.key, this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return BlocProvider(
              create: (context) => sl<DynamicTextFieldCubit>(),
              child: CreateCollectionSheet(),
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.oslo800,
        padding: EdgeInsets.all(12.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 8.w,
            children: [
              Icon(
                Icons.add,
                size: 24.w,
                color: AppColor.turquoise500,
              ),
              Text("Bộ sưu tập mới"),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 20.w,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
