import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCountCubit extends Cubit<int> {
  NotificationCountCubit() : super(0);

  void increment() => emit(state + 1);
  void reset() => emit(0);
}