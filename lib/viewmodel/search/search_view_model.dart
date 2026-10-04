import 'package:edencrew_assignment_starter/core/error/app_exception.dart';
import 'package:edencrew_assignment_starter/core/error/error_code.dart';
import 'package:edencrew_assignment_starter/core/provider/provider.dart';
import 'package:edencrew_assignment_starter/domain/entity/stock_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchState {
  SearchState({
    this.inputText = '',
    this.results = const [],
    this.isLoading = false,
    this.errorCode,
  });
  final String inputText;
  final List<StockEntity> results;
  final bool isLoading;
  final ErrorCode? errorCode;

  SearchState copyWith({
    String? inputText,
    List<StockEntity>? results,
    bool? isLoading,
    ErrorCode? errorCode,
  }) {
    return SearchState(
      inputText: inputText ?? this.inputText,
      results: results ?? this.results,
      isLoading: isLoading ?? this.isLoading,
      errorCode: errorCode ?? this.errorCode,
    );
  }
}

class SearchViewModel extends Notifier<SearchState> {
  @override
  build() {
    return SearchState();
  }

  void textClear() {
    state = SearchState();
  }

  Future<void> searchStocks(String inputText) async {
    final text = inputText.trim();
    if (text.isEmpty) {
      state = SearchState();
      return;
    }
    state = state.copyWith(isLoading: true, inputText: text);
    try {
      final result = await ref.read(stockRepoProvider).searchStocks(text);
      if (state.inputText != text) return;
      state = state.copyWith(
        inputText: text,
        results: result,
        isLoading: false,
      );
    } catch (e) {
      if (state.inputText != text) return;
      state = SearchState(
        inputText: text,
        errorCode: toAppException(e).errorCode,
      );
    }
  }
}

final searchViewModelProvider = NotifierProvider<SearchViewModel, SearchState>(
  () => SearchViewModel(),
);
