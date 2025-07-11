import 'package:app_homieopen_3047/core/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/video/video_bloc.dart';
import '../../cubits/multi_pagination_cubit.dart';
import '../../cubits/page_manage_cubit.dart';
import '../../cubits/video_control_cubit.dart';
import '../../cubits/video_player_cubit.dart';
import 'video_page_item.dart';

class VideoListPageView extends StatefulWidget {
  const VideoListPageView({super.key, required this.mainIndex});
  final int mainIndex;

  @override
  State<VideoListPageView> createState() => _VideoListPageViewState();
}

class _VideoListPageViewState extends State<VideoListPageView> {
  final PageController _pageController = PageController();
  late final VideoCategory category;

  @override
  void initState() {
    super.initState();
    category = _getCategoryFromIndex(widget.mainIndex);
    final videos = context.read<VideoBloc>().state.getListByCategory(category);
    if (videos.isEmpty) {
      context.read<VideoBloc>().add(GetVideosEvent(
            category: category,
            page: 1,
            isLoadMore: false,
          ));
    }
  }

  VideoCategory _getCategoryFromIndex(int index) {
    switch (index) {
      case 0:
        return VideoCategory.recommended;
      case 1:
        return VideoCategory.short;
      case 2:
        return VideoCategory.long;
      default:
        return VideoCategory.recommended;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageManageCubit, PageManageState>(
      builder: (context, pageState) {
        final isActive = widget.mainIndex == pageState.indexParentPage;
        return BlocBuilder<VideoBloc, VideoState>(
          builder: (context, videoState) {
            final videos = videoState.getListByCategory(category);
            final isLoading = videoState.getLoadingByCategory(category);
            debugPrint("State: $videoState");
            return PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: videos.length + 1,
              physics: pageState.showBottomSheet
                  ? NeverScrollableScrollPhysics()
                  : AlwaysScrollableScrollPhysics(),
              onPageChanged: (index) {
                if (index < videos.length) {
                  final videoId = videos[index].link;
                  context.read<PageManageCubit>().changeChildPage(index);
                  context.read<VideoPlayerCubit>().play(videoId);
                  context.read<VideoPlayerCubit>().unmute(videoId);
                }

                // Cuộn đến gần cuối → load thêm
                if (index == videos.length - 1 && !isLoading) {
                  final cubit = context.read<MultiPaginationCubit>();
                  final page = cubit.getState(category).currentPage + 1;

                  cubit.increasePage(category);
                  context.read<VideoBloc>().add(GetVideosEvent(
                        category: category,
                        page: page,
                        isLoadMore: true,
                      ));
                }
              },
              itemBuilder: (context, index) {
                if (index < videos.length) {
                  return BlocProvider(
                    create: (context) => sl<VideoControlCubit>(),
                    child: Container(
                      alignment: Alignment.center,
                      child: VideoPageItem(
                        key: ValueKey(videos[index]),
                        video: videos[index],
                        videos: videos,
                        isPlaying:
                            index == pageState.indexChildPage && isActive,
                        showBottomSheet: pageState.showBottomSheet,
                        pageController: _pageController,
                      ),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          },
        );
      },
    );
  }
}
