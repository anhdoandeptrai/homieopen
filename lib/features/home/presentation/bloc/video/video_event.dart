part of "video_bloc.dart";

abstract class VideoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

enum VideoCategory { recommended, short, long }

class GetVideosEvent extends VideoEvent {
  final VideoCategory category;
  final int page;
  final bool isLoadMore;

  GetVideosEvent({
    required this.category,
    required this.page,
    this.isLoadMore = false,
  });

  @override
  List<Object> get props => [category, page, isLoadMore];
}
