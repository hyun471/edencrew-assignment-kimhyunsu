import 'package:edencrew_assignment_starter/core/error/app_exception.dart';
import 'package:edencrew_assignment_starter/core/error/error_code.dart';
import 'package:edencrew_assignment_starter/core/provider/provider.dart';
import 'package:edencrew_assignment_starter/domain/entity/daily_entity.dart';
import 'package:edencrew_assignment_starter/domain/entity/period.dart';
import 'package:edencrew_assignment_starter/domain/entity/realtime_entity.dart';
import 'package:edencrew_assignment_starter/domain/entity/stock_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailState {
  DetailState({
    this.stock,
    this.quote,
    this.period = Period.oneMonth,
    this.daily = const [],
    this.isLoading = false,
    this.errorCode,
  });
  final StockEntity? stock;
  final RealtimeEntity? quote;
  final Period period;
  final List<DailyEntity> daily;
  final bool isLoading;
  final ErrorCode? errorCode;

  DetailState copyWith({
    StockEntity? stock,
    RealtimeEntity? quote,
    Period? period,
    List<DailyEntity>? daily,
    bool? isLoading,
    ErrorCode? errorCode,
  }) {
    return DetailState(
      stock: stock ?? this.stock,
      quote: quote ?? this.quote,
      period: period ?? this.period,
      daily: daily ?? this.daily,
      isLoading: isLoading ?? this.isLoading,
      errorCode: errorCode ?? this.errorCode,
    );
  }
}

class DetailViewModel extends Notifier<DetailState> {
  @override
  build() {
    return DetailState();
  }

  Future<void> getStockDetail(String code) async {
    state = DetailState(isLoading: true);
    try {
      final stock = await ref.read(stockRepoProvider).getStockData(code);
      final quotes = await ref.read(realtimeRepoProvider).getRealtimeData([
        code,
      ]);
      final daily = await _fetchDaily(code, Period.oneMonth);
      state = DetailState(stock: stock, quote: quotes[code], daily: daily);
    } catch (e) {
      state = DetailState(errorCode: toAppException(e).errorCode);
    }
  }

  Future<void> changePeriod(Period period) async {
    final stock = state.stock;
    if (stock == null) return;

    state = DetailState(
      stock: stock,
      quote: state.quote,
      period: period,
      daily: state.daily,
      isLoading: true,
    );
    try {
      final daily = await _fetchDaily(stock.code, period);
      state = DetailState(
        stock: stock,
        quote: state.quote,
        period: period,
        daily: daily,
      );
    } catch (e) {
      state = DetailState(
        stock: stock,
        quote: state.quote,
        period: period,
        daily: state.daily,
        errorCode: toAppException(e).errorCode,
      );
    }
  }

  Future<List<DailyEntity>> _fetchDaily(String code, Period period) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return ref
        .read(stockDailyRepoProvider)
        .getStoreData(
          stockCode: code,
          startDateTime: period.startFrom(today),
          endDateTime: now,
        );
  }
}

// 상세 화면을 나가면 상태를 지운다 (다른 종목으로 들어갈 때 이전 종목이 보이지 않게)
final detailViewModelProvider =
    NotifierProvider.autoDispose<DetailViewModel, DetailState>(
      () => DetailViewModel(),
    );
