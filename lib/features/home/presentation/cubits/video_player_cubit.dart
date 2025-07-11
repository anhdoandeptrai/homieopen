import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class VideoPlayerState {
  final Map<String, bool> pausedMap;

  VideoPlayerState({required this.pausedMap});

  VideoPlayerState copyWith({Map<String, bool>? pausedMap}) {
    return VideoPlayerState(pausedMap: pausedMap ?? this.pausedMap);
  }

  bool isPaused(String videoId) {
    return pausedMap[videoId] ?? false;
  }
}

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerCubit() : super(VideoPlayerState(pausedMap: {}));

  final Map<String, InAppWebViewController> _controllers = {};

  void registerController(String videoId, InAppWebViewController controller) {
    _controllers[videoId] = controller;
  }

  void unregisterController(String videoId) {
    _controllers.remove(videoId);
  }

  void pauseAll() {
    for (final controller in _controllers.values) {
      controller.evaluateJavascript(
        source: 'window.flutterVimeoPlayer.pause();',
      );
    }
    // new
    emit(state.copyWith(pausedMap: {
      for (final id in _controllers.keys) id: true,
    }));
  }

  void muteAll() {
    for (final controller in _controllers.values) {
      controller.evaluateJavascript(
        source: 'flutterVimeoPlayer.mute();',
      );
    }
  }

  void play(String videoId) {
    final controller = _controllers[videoId];
    controller?.evaluateJavascript(
      source: 'window.flutterVimeoPlayer.play();',
    );
    // new
    emit(state.copyWith(pausedMap: {
      ...state.pausedMap,
      videoId: false,
    }));
  }

  // new
  bool isPaused(String id) => state.pausedMap[id] ?? false;

  void updatePausedMap(String id) {
    emit(state.copyWith(pausedMap: {
      ...state.pausedMap,
      id: false,
    }));
  }

  void unmute(String videoId) {
    final controller = _controllers[videoId];
    debugPrint("[VideoPlayerCubit] UNMUTE $videoId | controller: $controller");
    controller?.evaluateJavascript(
      source: 'flutterVimeoPlayer.unmute();',
    );
  }

  void clear() {
    _controllers.clear();
  }
}
