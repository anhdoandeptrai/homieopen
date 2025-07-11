import 'package:app_homieopen_3047/core/utils/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/video/video_entity.dart';
import '../../../domain/usecase/get_long_videos_usecase.dart';
import '../../../domain/usecase/get_recommended_videos_usecase.dart';
import '../../../domain/usecase/get_short_videos_usecase.dart';
import '../../cubits/multi_pagination_cubit.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final GetRecommendedVideosUsecase _getRecommendedVideosUsecase;
  final GetShortVideosUsecase _getShortVideosUsecase;
  final GetLongVideosUsecase _getLongVideosUsecase;
  late MultiPaginationCubit paginationCubit;
  VideoBloc({
    required GetRecommendedVideosUsecase getRecommendedVideosUsecase,
    required GetShortVideosUsecase getShortVideosUsecase,
    required GetLongVideosUsecase getLongVideosUsecase,
    required this.paginationCubit,
  })  : _getRecommendedVideosUsecase = getRecommendedVideosUsecase,
        _getShortVideosUsecase = getShortVideosUsecase,
        _getLongVideosUsecase = getLongVideosUsecase,
        super(const VideoState()) {
    on<GetVideosEvent>(_onGetVideos);
  }

  void _onGetVideos(
    GetVideosEvent event,
    Emitter<VideoState> emit,
  ) async {
    final currentState = state;

    switch (event.category) {
      case VideoCategory.recommended:
        if (!event.isLoadMore) {
          emit(currentState.copyWith(isLoadingRecommended: true));
        }
        final res = await _getRecommendedVideosUsecase(event.page);
        _handleResult<VideoEntity>(
          res: res,
          emit: emit,
          getList: (s) => s.recommendedVideos,
          updateList: (s, list) => s.copyWith(recommendedVideos: list),
          updateError: (s, msg) => s.copyWith(errorRecommended: msg),
          updateLoading: (s, loading) =>
              s.copyWith(isLoadingRecommended: loading),
          isLoadMore: event.isLoadMore,
          category: event.category,
        );
        break;

      case VideoCategory.short:
        if (!event.isLoadMore) {
          emit(currentState.copyWith(isLoadingShort: true));
        }
        final res = await _getShortVideosUsecase(event.page);
        _handleResult<VideoEntity>(
          res: res,
          emit: emit,
          getList: (s) => s.shortVideos,
          updateList: (s, list) => s.copyWith(shortVideos: list),
          updateError: (s, msg) => s.copyWith(errorShort: msg),
          updateLoading: (s, loading) => s.copyWith(isLoadingShort: loading),
          isLoadMore: event.isLoadMore,
          category: event.category,
        );
        break;

      case VideoCategory.long:
        if (!event.isLoadMore) {
          emit(currentState.copyWith(isLoadingLong: true));
        }
        final res = await _getLongVideosUsecase(event.page);
        _handleResult<VideoEntity>(
          res: res,
          emit: emit,
          getList: (s) => s.longVideos,
          updateList: (s, list) => s.copyWith(longVideos: list),
          updateError: (s, msg) => s.copyWith(errorLong: msg),
          updateLoading: (s, loading) => s.copyWith(isLoadingLong: loading),
          isLoadMore: event.isLoadMore,
          category: event.category,
        );
        break;
    }
  }

  void _handleResult<T>({
    required Either<Failure, List<T>> res,
    required Emitter<VideoState> emit,
    required List<T> Function(VideoState) getList,
    required VideoState Function(VideoState, List<T>) updateList,
    required VideoState Function(VideoState, String) updateError,
    required VideoState Function(VideoState, bool) updateLoading,
    required bool isLoadMore,
    required VideoCategory category,
  }) {
    final currentState = state;

    res.fold(
      (failure) {
        paginationCubit.updateState(
          category,
          paginationCubit.getState(category).copyWith(isLoadingMore: false),
        );
        emit(
          updateError(
            updateLoading(currentState, false),
            failure.message,
          ),
        );
      },
      (videos) {
        debugPrint("List: $videos");
        final hasReachedEnd = videos.length < 10;
        paginationCubit.updateLoadingAndEnd(
          category: category,
          isLoadingMore: false,
          hasReachedEnd: hasReachedEnd,
        );

        final updatedList =
            isLoadMore ? [...getList(currentState), ...videos] : videos;

        emit(
          updateLoading(
            updateList(currentState, updatedList),
            false,
          ),
        );
      },
    );
  }

  void injectPaginationCubit(MultiPaginationCubit cubit) =>
      paginationCubit = cubit;
}
