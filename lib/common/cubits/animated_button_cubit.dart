import 'package:flutter_bloc/flutter_bloc.dart';

class AnimatedButtonCubit extends Cubit<bool> {
  AnimatedButtonCubit() : super(false); // false = không nhấn

  void pressDown() => emit(true);    // đang nhấn
  void pressUp() => emit(false);     // thả ra
}
