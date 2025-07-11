import 'package:app_homieopen_3047/common/helpers/custom_toastification.dart';
import 'package:app_homieopen_3047/common/widgets/custom_image_network.dart';
import 'package:app_homieopen_3047/common/widgets/custom_is_authorized.dart';
import 'package:app_homieopen_3047/core/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/video/video_entity.dart';
import '../../cubits/heart_animation_cubit.dart';
import '../../cubits/button_like_cubit.dart';
import '../../cubits/page_manage_cubit.dart';
import '../../cubits/read_more_cubit.dart';
import '../../cubits/video_control_cubit.dart';
import '../../cubits/video_player_cubit.dart';
import '../../helpers/vimeo_js.dart';
import '../interactive/drag_bottom_sheet.dart';
import '../interactive/group_button.dart';
import 'animated_heart_widget.dart';
import 'pause_icon.dart';
import 'video_description.dart';
import 'video_slider.dart';

class VideoPageItem extends StatefulWidget {
  const VideoPageItem({
    super.key,
    required this.video,
    required this.videos,
    required this.isPlaying,
    required this.showBottomSheet,
    required this.pageController,
  });
  final VideoEntity video;
  final List<dynamic> videos;
  final bool isPlaying;
  final bool showBottomSheet;
  final PageController pageController;

  @override
  State<VideoPageItem> createState() => _VideoPageItemState();
}

class _VideoPageItemState extends State<VideoPageItem>
    with SingleTickerProviderStateMixin {
  InAppWebViewController? webViewController;
  late final VideoPlayerCubit _videoPlayerCubit;
  late final AnimationController _slideController;
  late final Animation<Offset> _slideAnimation;
  bool _hasError = false;
  bool _hasPlayedOnce = false;

  @override
  void initState() {
    super.initState();
    // Animation slide video
    _slideController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, -0.33),
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _videoPlayerCubit = context.read<VideoPlayerCubit>();
  }

  @override
  void didUpdateWidget(covariant VideoPageItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isPlaying && !oldWidget.isPlaying && _hasPlayedOnce) {
      // Mới được hiển thị → play
      Future.delayed(Duration(milliseconds: 300), () {
        if (!mounted || webViewController == null) return;
        _hasError = false;
        webViewController?.evaluateJavascript(
          source: VimeoJs.play,
        );
        webViewController?.evaluateJavascript(
          source: VimeoJs.unmute,
        );
        if (!mounted) return;
        // Resume lại
        context.read<VideoControlCubit>().updatePaused(false);
      });
    } else if (!widget.isPlaying && oldWidget.isPlaying) {
      // Bị chuyển khỏi trang → pause
      webViewController!.evaluateJavascript(
        source: VimeoJs.pause,
      );
      // Update UI icon pause
      context.read<VideoControlCubit>().updatePaused(true);
    }

    // Animation slide video
    if (widget.showBottomSheet != oldWidget.showBottomSheet) {
      if (widget.showBottomSheet) {
        _slideController.forward(); // trượt lên
      } else {
        _slideController.reverse(); // trượt xuống
        context.read<PageManageCubit>().closeBottomSheet();
      }
    }
  }

  @override
  void dispose() {
    if (webViewController != null) {
      _videoPlayerCubit.unregisterController(widget.video.link);
      webViewController = null;
    }
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Thumbnail: ${widget.video.thumbnail}");
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ReadMoreCubit>()),
      ],
      child: CustomIsAuthorized(builder: (isAuthorized) {
        return BlocBuilder<VideoControlCubit, VideoControlState>(
          builder: (context, state) {
            final videoControlCubit = context.read<VideoControlCubit>();
            return Container(
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenHeight,
              color: Color.fromARGB(255, 30, 30, 30),
              child: Stack(
                children: [
                  SlideTransition(
                    position: _slideAnimation,
                    child: Stack(
                      children: [
                        Center(
                          child: IgnorePointer(
                            ignoring: true,
                            child: InAppWebView(
                              initialSettings: InAppWebViewSettings(
                                mediaPlaybackRequiresUserGesture: false,
                                javaScriptEnabled: true,
                                transparentBackground: true,
                                allowsInlineMediaPlayback: true,
                              ),
                              onWebViewCreated: (controller) async {
                                webViewController = controller;
                                final videoId = widget.video.link;
                                videoControlCubit.showThumbnail();
                                _videoPlayerCubit.registerController(
                                  videoId,
                                  controller,
                                );
                                controller.addJavaScriptHandler(
                                  handlerName: 'duration',
                                  callback: (args) {
                                    final dur = (args[0] as num).toDouble();
                                    videoControlCubit.updateDuration(dur);
                                  },
                                );

                                controller.addJavaScriptHandler(
                                  handlerName: 'currentTime',
                                  callback: (args) {
                                    final pos = (args[0] as num).toDouble();
                                    videoControlCubit.updateCurrentTime(pos);
                                  },
                                );
                                controller.addJavaScriptHandler(
                                  handlerName: 'isPaused',
                                  callback: (args) {
                                    final isPaused = args[0] as bool;
                                    videoControlCubit.updatePaused(isPaused);
                                  },
                                );
                                controller.addJavaScriptHandler(
                                  handlerName: 'videoStarted',
                                  callback: (_) {
                                    videoControlCubit.hideThumbnail();
                                    context
                                        .read<VideoPlayerCubit>()
                                        .unmute(videoId);
                                  },
                                );

                                await controller.loadFile(
                                  assetFilePath: VimeoJs.htmlPath,
                                );
                              },
                              onLoadStop: (controller, url) async {
                                await controller.evaluateJavascript(
                                  source: VimeoJs.init(widget.video.link),
                                );
                                await controller.evaluateJavascript(
                                  source: VimeoJs.getDuration,
                                );
                                if (widget.isPlaying && !_hasPlayedOnce) {
                                  await Future.delayed(
                                      Duration(milliseconds: 200));
                                  if (!mounted) return;
                                  controller.evaluateJavascript(
                                    source: VimeoJs.play,
                                  );
                                  webViewController!.evaluateJavascript(
                                    source: VimeoJs.unmute,
                                  );
                                  _hasPlayedOnce = true;
                                }
                              },
                              onConsoleMessage: (controller, message) {
                                final text = message.message;
                                if (_hasError || !widget.isPlaying) return;
                                if (text.contains('NotFoundError') ||
                                    text.contains(
                                        'This video does not exist')) {
                                  _hasError = true;
                                  CustomToastification.error(
                                    context,
                                    "Chuyển sang video tiếp theo",
                                    title: "Video không tồn tại",
                                  );
                                  final currentState =
                                      context.read<PageManageCubit>().state;
                                  final nextIndex =
                                      currentState.indexChildPage + 1;
                                  if (nextIndex < widget.videos.length) {
                                    context
                                        .read<PageManageCubit>()
                                        .changeChildPage(nextIndex);
                                    widget.pageController.animateToPage(
                                      nextIndex,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                        // Pause Icon
                        PauseIcon(
                          isPaused: state.isPaused,
                          vimeoId: widget.video.link,
                        ),
                      ],
                    ),
                  ),
                  if (state.showThumbnail && widget.isPlaying)
                    Positioned.fill(
                      child: CustomImageNetwork(
                        image: widget.video.thumbnail,
                        isAPI: true,
                      ),
                    ),
                  GestureDetector(
                    // Toggle play/pause video
                    onTap: () async {
                      _videoPlayerCubit.updatePausedMap(widget.video.link);
                      if (!mounted || webViewController == null) return;
                      await webViewController!.evaluateJavascript(
                        source: VimeoJs.playPause,
                      );
                      await Future.delayed(const Duration(milliseconds: 150));
                      await webViewController?.evaluateJavascript(
                        source: VimeoJs.getIsPaused,
                      );
                    },
                    // Double tap like video
                    onDoubleTapDown: isAuthorized
                        ? (details) {
                            final pos = details.globalPosition;
                            context.read<HeartAnimationCubit>().addHeart(pos);
                            context.read<ButtonLikeCubit>().setLiked();
                          }
                        : (details) => debugPrint("Chưa đăng nhập"),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.transparent,
                      child:
                          BlocBuilder<HeartAnimationCubit, List<AnimatedHeart>>(
                        builder: (context, hearts) {
                          return Stack(
                            children: [
                              // Show heart when double tap
                              ...hearts.map((heart) => AnimatedHeartWidget(
                                  key: ValueKey(heart.id),
                                  position: heart.position)),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  // Slider
                  VideoSlider(
                    webViewController: webViewController,
                    cubit: videoControlCubit,
                  ),
                  // Description and Group Button
                  _descriptionAndGroupButton(context, state.isDragging),
                  // Bottom Sheet
                  DragBottomSheet(showBottomSheet: widget.showBottomSheet),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  Widget _descriptionAndGroupButton(BuildContext context, bool isDragging) {
    return Visibility(
      visible: !widget.showBottomSheet && !isDragging,
      child: Positioned(
        bottom: 40.h,
        left: 16.w,
        right: 0,
        child: Row(
          spacing: 40.w,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(child: VideoDescription(video: widget.video)),
            GroupButton(),
          ],
        ),
      ),
    );
  }
}
