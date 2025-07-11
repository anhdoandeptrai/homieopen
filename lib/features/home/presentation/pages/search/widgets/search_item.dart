import 'package:app_homieopen_3047/common/cubits/animated_button_cubit.dart';
import 'package:app_homieopen_3047/core/di/injection.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({
    super.key,
    this.isHistory = false,
    required this.text,
    this.onTap,
  });
  final void Function()? onTap;
  final bool isHistory;
  final String text;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AnimatedButtonCubit>(),
      child: BlocBuilder<AnimatedButtonCubit, bool>(
        builder: (context, state) {
          final cubit = context.read<AnimatedButtonCubit>();
          return GestureDetector(
            onTapDown: (v) => cubit.pressDown(),
            onTapUp: (v) => cubit.pressUp(),
            onTapCancel: () => cubit.pressUp(),
            onTap: onTap,
            child: AnimatedContainer(
              duration: Duration(microseconds: 500),
              curve: Curves.easeInOut,
              padding: EdgeInsets.all(16.w),
              color: state ? AppColor.turquoise500 : Colors.transparent,
              child: Row(
                spacing: 6.w,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 6.w,
                    children: [
                      Icon(
                        isHistory ? Icons.history : Icons.search,
                        size: 22.w,
                        color: Colors.white,
                      ),
                      Text(
                        text,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Visibility(
                    visible: isHistory,
                    child: InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.close,
                        size: 22.w,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
