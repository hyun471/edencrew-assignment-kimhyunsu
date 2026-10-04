import 'package:edencrew_assignment_starter/core/error/app_exception.dart';
import 'package:edencrew_assignment_starter/data/data_source/daily_api_data_source.dart';
import 'package:edencrew_assignment_starter/domain/entity/daily_entity.dart';
import 'package:edencrew_assignment_starter/domain/repositories/stock_daily_repo.dart';

class StockDailyRepoImpl implements StockDailyRepo {
  const StockDailyRepoImpl(this._dailyDataSource);
  final DailyApiDataSource _dailyDataSource;

  @override
  Future<List<DailyEntity>> getStockDateData({
    required String stockCode,
    required DateTime startDateTime,
    required DateTime endDateTime,
  }) async {
    try {
      final response = await _dailyDataSource.stockDaily(
        stockCode,
        startDateTime,
        endDateTime,
      );
      final result = response
          .map(
            (data) => DailyEntity(
              date: DateTime.parse(data.localDate),
              openPrice: data.openPrice.toInt(),
              highPrice: data.highPrice.toInt(),
              lowPrice: data.lowPrice.toInt(),
              closePrice: data.closePrice.toInt(),
              volume: data.accumulatedTradingVolume.toInt(),
            ),
          )
          .toList();
      return result;
    } catch (e) {
      throw toAppException(e);
    }
  }
}
