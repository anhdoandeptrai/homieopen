import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubits/video_player_cubit.dart';

class PauseIcon extends StatelessWidget {
  const PauseIcon({super.key, required this.isPaused, required this.vimeoId});
  final bool isPaused;
  final String vimeoId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
      builder: (context, state) {
        final isCommonPaused = state.isPaused(vimeoId);
        return Center(
          child: Visibility(
            visible: isPaused || isCommonPaused,
            child: Icon(
              Icons.play_arrow_rounded,
              size: 150.w,
              color: Colors.white.withAlpha(180),
            ),
          ),
        );
      },
    );
  }
}
