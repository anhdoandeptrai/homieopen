import 'package:app_homieopen_3047/core/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubits/video_control_cubit.dart';

class VideoSlider extends StatelessWidget {
  const VideoSlider({
    super.key,
    this.webViewController,
    required this.cubit,
  });
  final InAppWebViewController? webViewController;
  final VideoControlCubit cubit;

  String formatDuration(double seconds) {
    final duration = Duration(seconds: seconds.floor());
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = duration.inHours;
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final secs = twoDigits(duration.inSeconds.remainder(60));

    return hours > 0 ? '$hours:$minutes:$secs' : '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: BlocBuilder<VideoControlCubit, VideoControlState>(
        builder: (context, state) {
          return Column(
            spacing: 16.h,
            children: [
              Visibility(
                visible: state.isDragging,
                child: Row(
                  spacing: 16.w,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      formatDuration(state.currentTime),
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "/",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      formatDuration(state.duration),
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: AppColor.oslo700, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: state.isDragging ? 5.h : 2.h,
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: state.isDragging ? 10.r : 5.r,
                    ),
                    overlayShape: RoundSliderOverlayShape(
                      overlayRadius: 12.r,
                    ),
                  ),
                  child: Slider(
                    value: state.currentTime.clamp(0, state.duration),
                    max: state.duration,
                    activeColor: AppColor.turquoise500,
                    inactiveColor: Colors.black.withAlpha(150),
                    thumbColor: Colors.white,
                    secondaryActiveColor: Colors.white,
                    onChanged: (value) => cubit.updateCurrentTime(value),
                    onChangeStart: (_) => cubit.startDragging(),
                    onChangeEnd: (value) {
                      cubit.endDragging();
                      webViewController!.evaluateJavascript(
                        source:
                            "window.flutterVimeoPlayer.setCurrentTime($value);",
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
