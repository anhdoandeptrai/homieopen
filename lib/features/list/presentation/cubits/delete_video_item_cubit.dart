import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteVideoItemState {
  final bool isEdit;
  final List<int> list;

  DeleteVideoItemState({
    this.isEdit = false,
    this.list = const [],
  });

  DeleteVideoItemState copyWith({
    bool? isEdit,
    List<int>? list,
  }) {
    return DeleteVideoItemState(
      isEdit: isEdit ?? this.isEdit,
      list: list ?? this.list,
    );
  }
}

class DeleteVideoItemCubit extends Cubit<DeleteVideoItemState> {
  DeleteVideoItemCubit() : super(DeleteVideoItemState());

  void startEdit() {
    emit(state.copyWith(
      isEdit: true,
    ));
  }

  void stopEdit() {
    emit(state.copyWith(isEdit: false, list: []));
  }

  void toggleSelection(int id) {
    final newSet = {...state.list};
    if (newSet.contains(id)) {
      newSet.remove(id);
    } else {
      newSet.add(id);
    }
    emit(state.copyWith(list: newSet.toList()));
  }

  bool isSelected(int id) => state.list.contains(id);

  void selectAllOrClear(List<int> allIds) {
    final currentSet = {...state.list};

    // Nếu đã chọn hết -> clear
    if (currentSet.length == allIds.length && currentSet.containsAll(allIds)) {
      emit(state.copyWith(list: []));
    } else {
      // Nếu chưa chọn hết -> chọn tất cả
      emit(state.copyWith(list: allIds));
    }
  }

  bool isAllSelected(List<int> allIds) {
    final selected = state.list;
    return selected.length == allIds.length &&
        selected.toSet().containsAll(allIds);
  }
}
