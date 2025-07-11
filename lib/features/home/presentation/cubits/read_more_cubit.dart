import 'package:flutter_bloc/flutter_bloc.dart';

class ReadMoreState {
  final bool isExpanded;
  final bool isOverflowing;
  final String visibleText;
  final String fullText;

  ReadMoreState({
    this.isExpanded = false,
    this.isOverflowing = false,
    this.visibleText = "",
    this.fullText = "",
  });

  ReadMoreState copyWith({
    bool? isExpanded,
    bool? isOverflowing,
    String? visibleText,
    String? fullText,
  }) {
    return ReadMoreState(
      isExpanded: isExpanded ?? this.isExpanded,
      isOverflowing: isOverflowing ?? this.isOverflowing,
      visibleText: visibleText ?? this.visibleText,
      fullText: fullText ?? this.fullText,
    );
  }
}

class ReadMoreCubit extends Cubit<ReadMoreState> {
  ReadMoreCubit() : super(ReadMoreState());

  void getFullText(String value) {
    emit(state.copyWith(fullText: value));
  }

  void toggle() => emit(state.copyWith(isExpanded: !state.isExpanded));

  void prepareOverflow({
    required String visibleText,
    required bool isOverflowing,
  }) {
    emit(state.copyWith(
      visibleText: visibleText,
      isOverflowing: isOverflowing,
    ));
  }
}
