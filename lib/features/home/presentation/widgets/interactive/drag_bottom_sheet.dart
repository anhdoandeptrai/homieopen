import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubits/page_manage_cubit.dart';
import '../collection/collection_sheet.dart';
import '../comment/comment_sheet.dart';
import '../episode/episode_list_sheet.dart';

class DragBottomSheet extends StatelessWidget {
  const DragBottomSheet({super.key, required this.showBottomSheet});
  final bool showBottomSheet;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: IgnorePointer(
        ignoring: !showBottomSheet,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: showBottomSheet ? 1.0 : 0.0,
          child: AnimatedSlide(
            offset: showBottomSheet ? Offset(0, 0) : Offset(0, 1),
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
            child: BlocBuilder<PageManageCubit, PageManageState>(
              builder: (context, state) {
                return KeyboardVisibilityBuilder(
                  builder: (context, isVisible) {
                    return MediaQuery.removeViewInsets(
                      context: context,
                      removeBottom: true,
                      child: GestureDetector(
                        onVerticalDragUpdate: (details) {
                          if (details.delta.dy > 0) {
                            context
                                .read<PageManageCubit>()
                                .onDragUp(details.delta.dy);
                          }
                        },
                        onVerticalDragEnd: (details) {
                          final cubit = context.read<PageManageCubit>();
                          if (state.dragOffset > 100 ||
                              details.primaryVelocity != null &&
                                  details.primaryVelocity! > 500) {
                            cubit.closeBottomSheet();
                            cubit.onDragDown();
                          } else {
                            cubit.onDragDown();
                          }
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: isVisible
                              ? ScreenUtil().screenHeight * 0.44
                              : ScreenUtil().screenHeight * 0.7,
                          decoration: BoxDecoration(
                            color: Color(0xFF1E1E1E),
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          transform:
                              Matrix4.translationValues(0, state.dragOffset, 0),
                          curve: Curves.easeOut,
                          child: state.isEpisodeSheet
                              ? EpisodeListSheet()
                              : state.isCollectionSheet
                                  ? CollectionSheet()
                                  : CommentSheet(),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
