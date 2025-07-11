part of "video_bloc.dart";

enum VideoTab { recommended, short, long }

class VideoState extends Equatable {
  final List<VideoEntity> recommendedVideos;
  final List<VideoEntity> shortVideos;
  final List<VideoEntity> longVideos;

  final bool isLoadingRecommended;
  final bool isLoadingShort;
  final bool isLoadingLong;

  final String errorRecommended;
  final String errorShort;
  final String errorLong;

  final VideoTab currentTab;

  const VideoState({
    this.recommendedVideos = const [],
    this.shortVideos = const [],
    this.longVideos = const [],
    this.isLoadingRecommended = false,
    this.isLoadingShort = false,
    this.isLoadingLong = false,
    this.errorRecommended = '',
    this.errorShort = '',
    this.errorLong = '',
    this.currentTab = VideoTab.recommended,
  });

  VideoState copyWith({
    List<VideoEntity>? recommendedVideos,
    List<VideoEntity>? shortVideos,
    List<VideoEntity>? longVideos,
    bool? isLoadingRecommended,
    bool? isLoadingShort,
    bool? isLoadingLong,
    String? errorRecommended,
    String? errorShort,
    String? errorLong,
    VideoTab? currentTab,
  }) {
    return VideoState(
      recommendedVideos: recommendedVideos ?? this.recommendedVideos,
      shortVideos: shortVideos ?? this.shortVideos,
      longVideos: longVideos ?? this.longVideos,
      isLoadingRecommended: isLoadingRecommended ?? this.isLoadingRecommended,
      isLoadingShort: isLoadingShort ?? this.isLoadingShort,
      isLoadingLong: isLoadingLong ?? this.isLoadingLong,
      errorRecommended: errorRecommended ?? this.errorRecommended,
      errorShort: errorShort ?? this.errorShort,
      errorLong: errorLong ?? this.errorLong,
      currentTab: currentTab ?? this.currentTab,
    );
  }

  @override
  List<Object?> get props => [
        recommendedVideos,
        shortVideos,
        longVideos,
        isLoadingRecommended,
        isLoadingShort,
        isLoadingLong,
        errorRecommended,
        errorShort,
        errorLong,
        currentTab,
      ];
}

extension VideoStateHelper on VideoState {
  List<dynamic> getListByCategory(VideoCategory category) {
    switch (category) {
      case VideoCategory.recommended:
        return recommendedVideos;
      case VideoCategory.short:
        return shortVideos;
      case VideoCategory.long:
        return longVideos;
    }
  }

  bool getLoadingByCategory(VideoCategory category) {
    switch (category) {
      case VideoCategory.recommended:
        return isLoadingRecommended;
      case VideoCategory.short:
        return isLoadingShort;
      case VideoCategory.long:
        return isLoadingLong;
    }
  }
}
