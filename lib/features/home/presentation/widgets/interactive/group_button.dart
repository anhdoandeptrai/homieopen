import 'package:app_homieopen_3047/common/helpers/show_alert_dialog.dart';
import 'package:app_homieopen_3047/common/widgets/custom_is_authorized.dart';
import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../auth/presentation/pages/signin_page.dart';
import '../../cubits/button_like_cubit.dart';
import '../../cubits/page_manage_cubit.dart';
import '../share/share_sheet.dart';
import 'interactive_button.dart';

class GroupButton extends StatelessWidget {
  const GroupButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16.h,
      children: [
        CustomIsAuthorized(builder: (isAuthorized) {
          return BlocBuilder<ButtonLikeCubit, ButtonLikeState>(
            builder: (context, state) {
              return TweenAnimationBuilder<double>(
                  tween:
                      Tween<double>(begin: 1.0, end: state.animate ? 1.2 : 1.0),
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeOutBack,
                  builder: (context, scale, child) {
                    return InteractiveButton(
                      onTap: () {
                        if (isAuthorized) {
                          context.read<ButtonLikeCubit>().toggleLike();
                        } else {
                          showAlertDialog(
                            context,
                            () => Navigator.push(context, SigninPage.route()),
                            () {},
                            "Thông báo",
                            "Hãy đăng nhập để có thể thích bộ phim này.",
                            "Đăng nhập",
                            "Từ chối",
                          );
                        }
                      },
                      icon: Icons.favorite,
                      color: state.isLiked ? Colors.red : Colors.white,
                      text: "100",
                      likeScale: scale,
                    );
                  });
            },
          );
        }),
        InteractiveButton(
          onTap: () => context.read<PageManageCubit>().openEpisodesSheet(),
          icon: Icons.layers,
          text: "100",
        ),
        InteractiveButton(
          onTap: () => context.read<PageManageCubit>().openCommentSheet(),
          icon: Icons.comment,
          text: "100",
        ),
        InteractiveButton(
          onTap: () => showModalBottomSheet(
            context: context,
            isScrollControlled: false,
            backgroundColor: AppColor.oslo800,
            builder: (context) {
              return IntrinsicHeight(child: ShareSheet());
            },
          ),
          icon: Icons.reply,
          text: "Chia sẻ",
        ),
        InteractiveButton(
          onTap: () {},
          icon: Icons.closed_caption,
          text: "Phụ đề",
        ),
        InteractiveButton(
          onTap: () => context.read<PageManageCubit>().openCollectionSheet(),
          icon: Icons.bookmark_border_outlined,
          text: "Lưu",
        ),
        // BlocBuilder<VideoControlCubit, VideoControlState>(
        //   builder: (context, state) {
        //     return InteractiveButton(
        //       onTap: () {
        //         if (state.isMuted) {
        //           controller!.evaluateJavascript(
        //             source: 'flutterVimeoPlayer.unmute();',
        //           );
        //         } else {
        //           controller!.evaluateJavascript(
        //             source: 'flutterVimeoPlayer.mute();',
        //           );
        //         }
        //         context.read<VideoControlCubit>().toggleMute();
        //       },
        //       icon: Icons.volume_up,
        //       text: state.isMuted ? "Bật loa" : "Tắt loa",
        //       color: state.isMuted ? Colors.white : AppColor.turquoise500,
        //     );
        //   },
        // ),
      ],
    );
  }
}
