import 'package:app_homieopen_3047/common/widgets/custom_image_network.dart';
import 'package:app_homieopen_3047/common/widgets/custom_textfield.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentFieldSheet extends StatefulWidget {
  const CommentFieldSheet({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<CommentFieldSheet> createState() => _CommentFieldSheetState();
}

class _CommentFieldSheetState extends State<CommentFieldSheet>
    with WidgetsBindingObserver {
  double _keyboardHeight = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newKeyboardHeight = MediaQuery.of(context).viewInsets.bottom;
      if (_keyboardHeight > 0 && newKeyboardHeight == 0) {
        // Bàn phím đã đóng → đóng bottom sheet
        Navigator.of(context).maybePop();
      }
      _keyboardHeight = newKeyboardHeight;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.oslo900,
      ),
      child: Row(
        spacing: 8.w,
        children: [
          ClipOval(
            child: CustomImageNetwork(
              image: "",
              width: 42.w,
              height: 42.w,
              isAvatar: true,
            ),
          ),
          Expanded(
            child: CustomTextfield(
              controller: widget.controller,
              autofocus: true,
              hintText: "Nhập bình luận",
              suffixIcon: InkWell(
                onTap: () {},
                child: Icon(
                  Icons.send,
                  color: AppColor.oslo500,
                  size: 22.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
