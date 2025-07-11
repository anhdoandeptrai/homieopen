import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class CountdownCubit extends Cubit<String> {
  CountdownCubit() : super('');

  int _minutes = 0;
  int _seconds = 60;
  Timer? _timer;

  int get minutes => _minutes;
  int get seconds => _seconds;
  Timer? get timer => _timer;

  void startCountdown() {
    emit('01:00');
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (_) {
        if (_seconds != 0) {
          --_seconds;
        } else {
          if (_minutes != 0) {
            --_minutes;
          } else {
            cancelCountdown();
          }
        }
        emit(
          '${_minutes.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')}',
        );
      },
    );
  }

  void cancelCountdown() {
    _timer?.cancel();
    _timer = null;
    _minutes = 0;
    _seconds = 60;
  }
}