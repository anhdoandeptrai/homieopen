import 'package:flutter_bloc/flutter_bloc.dart';

class HasValueCubit extends Cubit<bool> {
  HasValueCubit() : super(false);

  void checkHasValue(List<String> values) {
    final hasValue =
        values.isNotEmpty && values.every((e) => e.trim().isNotEmpty);
    if (hasValue != state) {
      emit(hasValue);
    }
  }
}