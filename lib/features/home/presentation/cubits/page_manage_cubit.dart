import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageManageState extends Equatable {
  final int indexParentPage;
  final int indexChildPage;
  final bool commonPlaying;
  final bool showBottomSheet;
  final bool isEpisodeSheet;
  final bool isCollectionSheet;
  final double dragOffset;

  const PageManageState({
    this.indexParentPage = 0,
    this.indexChildPage = 0,
    this.commonPlaying = true,
    this.showBottomSheet = false,
    this.isEpisodeSheet = false,
    this.isCollectionSheet = false,
    this.dragOffset = 0,
  });

  PageManageState copyWith({
    int? indexParentPage,
    int? indexChildPage,
    bool? commonPlaying,
    bool? showBottomSheet,
    bool? isEpisodeSheet,
    bool? isCollectionSheet,
    double? dragOffset,
  }) {
    return PageManageState(
      indexParentPage: indexParentPage ?? this.indexParentPage,
      indexChildPage: indexChildPage ?? this.indexChildPage,
      commonPlaying: commonPlaying ?? this.commonPlaying,
      showBottomSheet: showBottomSheet ?? this.showBottomSheet,
      isEpisodeSheet: isEpisodeSheet ?? this.isEpisodeSheet,
      isCollectionSheet: isCollectionSheet ?? this.isCollectionSheet,
      dragOffset: dragOffset ?? this.dragOffset,
    );
  }

  @override
  List<Object> get props => [
        indexParentPage,
        indexChildPage,
        commonPlaying,
        showBottomSheet,
        isEpisodeSheet,
        isCollectionSheet,
        dragOffset,
      ];
}

class PageManageCubit extends Cubit<PageManageState> {
  PageManageCubit() : super(const PageManageState());

  void changeParentPage(int index) {
    emit(state.copyWith(indexParentPage: index));
  }

  void changeChildPage(int index) {
    emit(state.copyWith(indexChildPage: index));
  }

  void updateCommentPlaying(bool value) {
    emit(state.copyWith(commonPlaying: value));
  }

  void openCommentSheet() {
    emit(state.copyWith(
      showBottomSheet: true,
      isEpisodeSheet: false,
      isCollectionSheet: false,
    ));
  }

  void openEpisodesSheet() {
    emit(state.copyWith(
      showBottomSheet: true,
      isEpisodeSheet: true,
      isCollectionSheet: false,
    ));
  }

  void openCollectionSheet() {
    emit(state.copyWith(
      showBottomSheet: true,
      isEpisodeSheet: false,
      isCollectionSheet: true,
    ));
  }

  void closeBottomSheet() {
    emit(state.copyWith(
      showBottomSheet: false,
      isEpisodeSheet: false,
      isCollectionSheet: false,
    ));
  }

  void onDragUp(double details) {
    emit(state.copyWith(dragOffset: state.dragOffset + details));
  }

  void onDragDown() {
    emit(state.copyWith(dragOffset: 0));
  }
}
