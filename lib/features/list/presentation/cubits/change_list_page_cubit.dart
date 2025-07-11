import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeListPageCubit extends Cubit<int> {
  ChangeListPageCubit() : super(0);

  void changePage(int index) {
    emit(index);
  }
}

class ChangeContentPageCubit extends Cubit<int> {
  ChangeContentPageCubit() : super(0);

  void changePage(int index) {
    emit(index);
  }
}
