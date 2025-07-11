import 'package:app_homieopen_3047/common/cubits/has_value_cubit.dart';
import 'package:app_homieopen_3047/core/di/injection.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onChanged,
    this.onFieldSubmitted,
  });
  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HasValueCubit>(),
      child: BlocBuilder<HasValueCubit, bool>(
        builder: (context, state) {
          return TextFormField(
            controller: controller,
            focusNode: focusNode,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Tìm kiếm",
              hintStyle: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: AppColor.oslo600),
              fillColor: Color(0xff7E8384).withAlpha(70),
              contentPadding: EdgeInsets.symmetric(horizontal: 6.w),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.transparent)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.transparent)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.transparent)),
              prefixIcon: Icon(
                Icons.search,
                size: 22.w,
                color: AppColor.oslo600,
              ),
              suffixIcon: Visibility(
                visible: state,
                child: GestureDetector(
                  onTap: () {
                    controller.clear();
                  },
                  child: Icon(
                    Icons.close,
                    size: 22.w,
                    color: AppColor.oslo600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
