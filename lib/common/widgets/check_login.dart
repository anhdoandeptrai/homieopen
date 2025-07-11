import 'package:app_homieopen_3047/common/widgets/custom_empty.dart';
import 'package:app_homieopen_3047/common/widgets/custom_is_authorized.dart';
import 'package:app_homieopen_3047/core/assets/app_image.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/signin_page.dart';

class CheckLogin extends StatelessWidget {
  const CheckLogin({super.key, required this.child, this.text});
  final Widget child;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return CustomIsAuthorized(
      builder: (isAuthorized) {
        if (!isAuthorized) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomEmpty(
                  image: AppImage.notLogin,
                  text:
                      "Vui lòng đăng nhập để ${text ?? "có thể sử dụng tính năng"}",
                  button: "Đăng nhập",
                  onPressed: () => Navigator.push(context, SigninPage.route()),
                ),
              ],
            ),
          );
        }
        return child;
      },
    );
  }
}
