import 'package:edencrew_assignment_starter/core/error/error_code.dart';
import 'package:edencrew_assignment_starter/core/provider/provider.dart';
import 'package:edencrew_assignment_starter/domain/entity/stock_entity.dart';
import 'package:edencrew_assignment_starter/domain/entity/watch_item.dart';
import 'package:edencrew_assignment_starter/domain/entity/watch_sort.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatchListState {
  WatchListState({
    this.items = const [],
    this.sort = WatchSort.name,
    this.isLoading = false,
    this.errorCode,
  });
  final List<WatchItem> items;
  final WatchSort sort;
  final bool isLoading;
  final ErrorCode? errorCode;

  WatchListState copyWith({
    List<WatchItem>? items,
    WatchSort? sort,
    bool? isLoading,
    ErrorCode? errorCode,
  }) {
    return WatchListState(
      items: items ?? this.items,
      sort: sort ?? this.sort,
      isLoading: isLoading ?? this.isLoading,
      errorCode: errorCode ?? this.errorCode,
    );
  }
}

class WatchListViewModel extends Notifier<WatchListState> {
  final Map<String, StockEntity> _stockCache = {};
  @override
  build() {
    return WatchListState();
  }

  Future<void> getStock(String stockCode) async {
    final repo = ref.watch(stockRepoProvider);
    final result = await repo.getStockData(stockCode);
    state = state.copyWith();
  }
}
