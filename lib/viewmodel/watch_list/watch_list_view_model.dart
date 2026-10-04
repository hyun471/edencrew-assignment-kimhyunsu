import 'package:edencrew_assignment_starter/core/error/app_exception.dart';
import 'package:edencrew_assignment_starter/core/error/error_code.dart';
import 'package:edencrew_assignment_starter/core/provider/provider.dart';
import 'package:edencrew_assignment_starter/domain/entity/realtime_entity.dart';
import 'package:edencrew_assignment_starter/domain/entity/stock_entity.dart';
import 'package:edencrew_assignment_starter/domain/entity/watch_sort.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatchListState {
  WatchListState({
    this.stocks = const [],
    this.price = const {},
    this.sort = WatchSort.name,
    this.ascending = true,
    this.isLoading = false,
    this.errorCode,
  });
  final List<StockEntity> stocks;
  final Map<String, RealtimeEntity> price;
  final WatchSort sort;
  final bool ascending;
  final bool isLoading;
  final ErrorCode? errorCode;

  WatchListState copyWith({
    List<StockEntity>? stocks,
    Map<String, RealtimeEntity>? price,
    WatchSort? sort,
    bool? ascending,
    bool? isLoading,
    ErrorCode? errorCode,
  }) {
    return WatchListState(
      stocks: stocks ?? this.stocks,
      price: price ?? this.price,
      sort: sort ?? this.sort,
      ascending: ascending ?? this.ascending,
      isLoading: isLoading ?? this.isLoading,
      errorCode: errorCode ?? this.errorCode,
    );
  }
}

class WatchListViewModel extends Notifier<WatchListState> {
  @override
  build() {
    return WatchListState();
  }

  bool isWatchedStock(String code) {
    final result = state.stocks.any((data) => data.code == code);
    return result;
  }

  void changeWatchedStock(StockEntity stock) {
    if (isWatchedStock(stock.code)) {
      final newList = state.stocks
          .where((data) => data.code != stock.code)
          .toList();
      state = state.copyWith(stocks: newList);
    } else {
      final newWatchedStockList = [...state.stocks, stock];
      state = state.copyWith(stocks: newWatchedStockList);
    }
    getStockPrice();
  }

  Future<void> getStockPrice() async {
    state = state.copyWith(isLoading: true);
    try {
      final watchStockCodeList = state.stocks.map((data) => data.code).toList();
      final repo = ref.read(realtimeRepoProvider);
      final result = await repo.getRealtimeData(watchStockCodeList);
      state = WatchListState(
        stocks: state.stocks,
        price: result,
        sort: state.sort,
      );
    } catch (e) {
      state = WatchListState(
        stocks: state.stocks,
        price: state.price,
        sort: state.sort,
        errorCode: toAppException(e).errorCode,
      );
    }
  }
}

final watchListViewModelProvider =
    NotifierProvider<WatchListViewModel, WatchListState>(
      () => WatchListViewModel(),
    );
