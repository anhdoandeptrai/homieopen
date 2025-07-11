import 'package:flutter_bloc/flutter_bloc.dart';

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

class PaginationCubit extends Cubit<PaginationState> {
  PaginationCubit()
      : super(PaginationState(
            currentPage: 1, isLoadingMore: false, hasReachedEnd: false));

  void startLoadingMore() => emit(state.copyWith(isLoadingMore: true));
  void stopLoadingMore() => emit(state.copyWith(isLoadingMore: false));
  void increasePage() =>
      emit(state.copyWith(currentPage: state.currentPage + 1));

  void setHasReachedEnd(bool value) =>
      emit(state.copyWith(hasReachedEnd: value));
  void updateLoadingAndEnd(
          {required bool isLoadingMore, required bool hasReachedEnd}) =>
      emit(state.copyWith(
        isLoadingMore: hasReachedEnd ? false : isLoadingMore,
        hasReachedEnd: hasReachedEnd,
      ));

  void reset() => emit(PaginationState(
      currentPage: 1, isLoadingMore: false, hasReachedEnd: false));
  void markEndReached() => emit(state.copyWith(hasReachedEnd: true));
  void setPage(int page) => emit(state.copyWith(currentPage: page));
}