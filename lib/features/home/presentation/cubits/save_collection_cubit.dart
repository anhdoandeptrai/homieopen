import 'package:flutter_bloc/flutter_bloc.dart';

class SaveCollectionState {
  final List<String> list;

  SaveCollectionState({
    this.list = const [],
  });

  SaveCollectionState copyWith({
    List<String>? list,
  }) {
    return SaveCollectionState(
      list: list ?? this.list,
    );
  }
}

class SaveCollectionCubit extends Cubit<SaveCollectionState> {
  SaveCollectionCubit() : super(SaveCollectionState());

  void toggleSelection(String collection) {
    final newSet = {...state.list};
    if (newSet.contains(collection)) {
      newSet.remove(collection);
    } else {
      newSet.add(collection);
    }
    emit(state.copyWith(list: newSet.toList()));
  }

  bool isSelected(String collection) => state.list.contains(collection);
}
