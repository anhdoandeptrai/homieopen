import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoControlState {
  final bool isPaused;
  final double duration;
  final double currentTime;
  final bool isDragging;
  final bool showThumbnail;
  final bool isMuted;

  VideoControlState({
    this.duration = 0.0,
    this.currentTime = 0.0,
    this.isDragging = false,
    this.isPaused = false,
    this.showThumbnail = true,
    this.isMuted = true,
  });

  VideoControlState copyWith({
    double? duration,
    double? currentTime,
    bool? isDragging,
    bool? isPaused,
    bool? showThumbnail,
    bool? isMuted,
  }) {
    return VideoControlState(
      duration: duration ?? this.duration,
      currentTime: currentTime ?? this.currentTime,
      isDragging: isDragging ?? this.isDragging,
      isPaused: isPaused ?? this.isPaused,
      showThumbnail: showThumbnail ?? this.showThumbnail,
      isMuted: isMuted ?? this.isMuted,
    );
  }
}

class VideoControlCubit extends Cubit<VideoControlState> {
  VideoControlCubit() : super(VideoControlState());

  void startDragging() => emit(state.copyWith(isDragging: true));

  void endDragging() => emit(state.copyWith(isDragging: false));

  void updateCurrentTime(double value) {
    emit(state.copyWith(currentTime: value));
  }

  void updateDuration(double value) {
    emit(state.copyWith(duration: value));
  }

  void updatePaused(bool isPaused) {
    emit(state.copyWith(isPaused: isPaused));
  }

  void showThumbnail() {
    emit(state.copyWith(showThumbnail: true));
  }

  void hideThumbnail() {
    emit(state.copyWith(showThumbnail: false));
  }

  void toggleMute() {
    if (state.isMuted) {
      emit(state.copyWith(isMuted: false));
    } else {
      emit(state.copyWith(isMuted: true));
    }
  }

  void updateMute(bool value) {
    emit(state.copyWith(isMuted: value));
  }

  @override
  Future<void> close() {
    debugPrint('VideoSliderCubit: Closing');
    return super.close();
  }
}
