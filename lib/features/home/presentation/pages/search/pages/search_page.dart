import 'package:app_homieopen_3047/common/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cubits/handle_search_cubit.dart';
import '../widgets/search_item.dart';
import '../widgets/search_results.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  static route() => MaterialPageRoute(builder: (context) => SearchPage());

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);

    _focusNode.addListener(() {
      context
          .read<HandleSearchCubit>()
          .onFocusChanged(_focusNode.hasFocus, _searchController.text);
    });
  }

  void _onSearchTextChanged() {
    context.read<HandleSearchCubit>().onTextChanged(_searchController.text);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: SearchField(
            controller: _searchController,
            focusNode: _focusNode,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: BlocBuilder<HandleSearchCubit, HandleSearchState>(
            builder: (context, state) {
              switch (state.uiState) {
                case SearchUIState.history:
                  return ListView.builder(
                    itemCount: state.searchHistory.length,
                    itemBuilder: (context, index) {
                      final historyItem = state.searchHistory[index];
                      return SearchItem(
                        isHistory: true,
                        text: historyItem,
                        onTap: () {
                          final cubit = context.read<HandleSearchCubit>();
                          _searchController
                              .removeListener(_onSearchTextChanged);
                          _searchController.text = historyItem;
                          _searchController.addListener(_onSearchTextChanged);
                          cubit.goToResult(historyItem);
                          _focusNode.unfocus();
                        },
                      );
                    },
                  );
                case SearchUIState.suggestion:
                  if (state.suggestions.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 48, color: Colors.grey),
                          SizedBox(height: 12),
                          Text(
                            'Không tìm thấy gợi ý',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.grey,
                                ),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: state.suggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = state.suggestions[index];
                      return SearchItem(
                        text: suggestion,
                        onTap: () {
                          final cubit = context.read<HandleSearchCubit>();
                          _searchController
                              .removeListener(_onSearchTextChanged);
                          _searchController.text = suggestion;
                          _searchController.addListener(_onSearchTextChanged);
                          cubit.submitSearch(suggestion);
                          _focusNode.unfocus();
                        },
                      );
                    },
                  );
                case SearchUIState.result:
                  return SearchResults(keyword: state.keyword);
              }
            },
          ),
        ),
      ),
    );
  }
}
