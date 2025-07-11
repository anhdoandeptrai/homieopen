import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/video/video_bloc.dart';

class PaginationState {
  final int currentPage;
  final bool isLoadingMore;
  final bool hasReachedEnd;

  PaginationState({
    required this.currentPage,
    required this.isLoadingMore,
    required this.hasReachedEnd,
  });

  PaginationState copyWith({
    int? currentPage,
    bool? isLoadingMore,
    bool? hasReachedEnd,
  }) {
    return PaginationState(
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
    );
  }
}

class MultiPaginationCubit extends Cubit<Map<VideoCategory, PaginationState>> {
  MultiPaginationCubit()
      : super({
          VideoCategory.recommended: PaginationState(
            currentPage: 1,
            isLoadingMore: false,
            hasReachedEnd: false,
          ),
          VideoCategory.short: PaginationState(
            currentPage: 1,
            isLoadingMore: false,
            hasReachedEnd: false,
          ),
          VideoCategory.long: PaginationState(
            currentPage: 1,
            isLoadingMore: false,
            hasReachedEnd: false,
          ),
        });

  PaginationState getState(VideoCategory category) => state[category]!;

  void updateState(VideoCategory category, PaginationState newState) {
    emit({...state, category: newState});
  }

  void updateLoadingAndEnd({
    required VideoCategory category,
    required bool isLoadingMore,
    required bool hasReachedEnd,
  }) {
    final old = getState(category);
    updateState(
      category,
      old.copyWith(
        isLoadingMore: hasReachedEnd ? false : isLoadingMore,
        hasReachedEnd: hasReachedEnd,
      ),
    );
  }

  void increasePage(VideoCategory category) {
    final old = getState(category);
    updateState(category, old.copyWith(currentPage: old.currentPage + 1));
  }

  void reset(VideoCategory category) {
    updateState(
      category,
      PaginationState(
        currentPage: 1,
        isLoadingMore: false,
        hasReachedEnd: false,
      ),
    );
  }
}
