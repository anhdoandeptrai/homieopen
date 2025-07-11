import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

enum SearchUIState { history, suggestion, result }

class HandleSearchState {
  final SearchUIState uiState;
  final String keyword;
  final List<String> searchHistory;
  final List<String> suggestions;

  HandleSearchState({
    required this.uiState,
    this.keyword = '',
    this.searchHistory = const [],
    this.suggestions = const [],
  });

  HandleSearchState copyWith({
    SearchUIState? uiState,
    String? keyword,
    List<String>? searchHistory,
    List<String>? suggestions,
  }) {
    return HandleSearchState(
      uiState: uiState ?? this.uiState,
      keyword: keyword ?? this.keyword,
      searchHistory: searchHistory ?? this.searchHistory,
      suggestions: suggestions ?? this.suggestions,
    );
  }
}

class HandleSearchCubit extends Cubit<HandleSearchState> {
  HandleSearchCubit()
      : super(HandleSearchState(
          uiState: SearchUIState.history,
          searchHistory: ['Penthouse', 'Apartment', 'Villa'],
          suggestions: [],
        )) {
    _setupDebounce();
  }

  final _textChangeSubject = PublishSubject<String>();

  void _setupDebounce() {
    _textChangeSubject
        .debounceTime(const Duration(milliseconds: 300))
        .listen((text) {
      if (text.isEmpty) {
        emit(state.copyWith(
          uiState: SearchUIState.history,
          keyword: '',
          suggestions: [],
        ));
      } else {
        if (text != state.keyword ||
            state.uiState != SearchUIState.suggestion) {
          final updatedSuggestions = _generateSuggestions(text);
          emit(state.copyWith(
            uiState: SearchUIState.suggestion,
            keyword: text,
            suggestions: updatedSuggestions,
          ));
        }
      }
    });
  }

  void onTextChanged(String text) {
    _textChangeSubject.add(text);
  }

  void onFocusChanged(bool hasFocus, String currentText) {
    if (hasFocus) {
      // Giao việc cho onTextChanged xử lý
      if (currentText.isEmpty) {
        emit(state.copyWith(uiState: SearchUIState.history, suggestions: []));
      }
    } else {
      // Khi mất focus, giữ suggestion nếu có text
      if (currentText.isEmpty) {
        emit(state.copyWith(
            uiState: SearchUIState.history, keyword: '', suggestions: []));
      }
    }
  }

  void submitSearch(String keyword) {
    final trimmed = keyword.trim();
    if (trimmed.isEmpty) return;

    final currentHistory = List<String>.from(state.searchHistory);

    if (!currentHistory.contains(trimmed)) {
      currentHistory.insert(0, trimmed);
    }

    emit(state.copyWith(
      uiState: SearchUIState.result,
      keyword: trimmed,
      searchHistory: currentHistory,
    ));
  }

  void goToResult(String keyword) {
    emit(state.copyWith(
      uiState: SearchUIState.result,
      keyword: keyword,
    ));
  }

  void backToHistory() {
    emit(state.copyWith(
        uiState: SearchUIState.history, keyword: '', suggestions: []));
  }

  List<String> _generateSuggestions(String query) {
    final allSuggestions = [
      'Penthouse in NYC',
      'Apartment Downtown',
      'Villa Beach',
      'Condo City',
      'House Suburb',
    ];
    return allSuggestions
        .where((s) => s.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Future<void> close() {
    _textChangeSubject.close();
    return super.close();
  }
}
