import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimatedHeart {
  final Offset position;
  final String id;

  AnimatedHeart({required this.position, required this.id});
}

class HeartAnimationCubit extends Cubit<List<AnimatedHeart>> {
  HeartAnimationCubit() : super([]);

  void addHeart(Offset position) {
    final newHeart = AnimatedHeart(
      position: position,
      id: UniqueKey().toString(),
    );

    final currentHearts = [...state, newHeart];
    emit(currentHearts);

    // Xoá tim sau 800ms
    Future.delayed(Duration(milliseconds: 1600), () {
      final updatedState = List<AnimatedHeart>.from(state);
      updatedState.removeWhere((heart) => heart.id == newHeart.id);
      emit(updatedState);
    });
  }
}
