import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonLikeState {
  final bool isLiked;
  final bool animate;

  ButtonLikeState({required this.isLiked, required this.animate});

  ButtonLikeState copyWith({bool? isLiked, bool? animate}) {
    return ButtonLikeState(
      isLiked: isLiked ?? this.isLiked,
      animate: animate ?? false,
    );
  }
}

class ButtonLikeCubit extends Cubit<ButtonLikeState> {
  ButtonLikeCubit() : super(ButtonLikeState(isLiked: false, animate: false));

  void toggleLike() {
    emit(ButtonLikeState(isLiked: !state.isLiked, animate: true));
    Future.delayed(Duration(milliseconds: 300), () {
      emit(state.copyWith(animate: false));
    });
  }

  void setLiked() {
    emit(ButtonLikeState(isLiked: true, animate: true));
    Future.delayed(Duration(milliseconds: 300), () {
      emit(state.copyWith(animate: false));
    });
  }
}
