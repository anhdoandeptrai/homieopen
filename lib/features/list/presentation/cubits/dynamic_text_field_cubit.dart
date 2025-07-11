import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class DynamicTextFieldCubit extends Cubit<List<TextEditingController>> {
  DynamicTextFieldCubit() : super([TextEditingController()]);

  void addTextField() {
    final newList = List<TextEditingController>.from(state);
    newList.add(TextEditingController());
    emit(newList);
  }

  void removeTextField(int index) {
    if (state.length <= 1) return;
    final updated = List<TextEditingController>.from(state);
    updated[index].dispose();
    updated.removeAt(index);
    emit(updated);
  }

  void disposeAll() {
    for (var controller in state) {
      controller.dispose();
    }
  }
}
