import 'package:app_homieopen_3047/common/cubits/is_authorized_cubit.dart';
import 'package:app_homieopen_3047/common/widgets/custom_empty.dart';
import 'package:app_homieopen_3047/common/widgets/header_bottom_sheet.dart';
import 'package:app_homieopen_3047/core/assets/app_image.dart';
import 'package:app_homieopen_3047/features/auth/presentation/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubits/page_manage_cubit.dart';
import 'comment_field.dart';
import 'comment_item.dart';

class CommentSheet extends StatefulWidget {
  const CommentSheet({super.key});

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  final _commentCon = TextEditingController();
  final _commentNode = FocusNode();
  @override
  void dispose() {
    _commentCon.dispose();
    _commentNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          HeaderBottomSheet(
            title: "Bình luận",
            onClose: () => context.read<PageManageCubit>().closeBottomSheet(),
          ),
          Expanded(
            child: BlocSelector<IsAuthorizedCubit, bool, bool>(
              selector: (state) => state,
              builder: (context, isAuthorized) {
                if (!isAuthorized) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomEmpty(
                        image: AppImage.notLogin,
                        text: "Vui lòng đăng nhập để có thể bình luận",
                        button: "Đăng nhập",
                        onPressed: () =>
                            Navigator.push(context, SigninPage.route()),
                      ),
                    ],
                  );
                }
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: ListView.builder(
                          itemCount: 30,
                          itemBuilder: (context, index) {
                            return CommentItem();
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CommentField(
                        controller: _commentCon,
                        focusNode: _commentNode,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
