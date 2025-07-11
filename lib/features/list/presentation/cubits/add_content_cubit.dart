import 'package:flutter_bloc/flutter_bloc.dart';

class AddContentState {
  final List<int> viewingList;
  final List<int> favoriteList;

  AddContentState({
    this.viewingList = const [],
    this.favoriteList = const [],
  });

  AddContentState copyWith({
    List<int>? viewingList,
    List<int>? favoriteList,
  }) {
    return AddContentState(
      viewingList: viewingList ?? this.viewingList,
      favoriteList: favoriteList ?? this.favoriteList,
    );
  }
}

class AddContentCubit extends Cubit<AddContentState> {
  AddContentCubit() : super(AddContentState());

  void toggleViewingSelection(int id) {
    final newSet = {...state.viewingList};
    if (newSet.contains(id)) {
      newSet.remove(id);
    } else {
      newSet.add(id);
    }
    emit(state.copyWith(viewingList: newSet.toList()));
  }

  void toggleFavoriteSelection(int id) {
    final newSet = {...state.favoriteList};
    if (newSet.contains(id)) {
      newSet.remove(id);
    } else {
      newSet.add(id);
    }
    emit(state.copyWith(favoriteList: newSet.toList()));
  }
}
