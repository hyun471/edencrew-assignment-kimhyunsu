import 'package:edencrew_assignment_starter/core/error/app_exception.dart';
import 'package:edencrew_assignment_starter/data/data_source/daily_api_data_source.dart';
import 'package:edencrew_assignment_starter/domain/entity/daily_entity.dart';
import 'package:edencrew_assignment_starter/domain/repositories/stock_daily_repo.dart';

class StockDailyRepoImpl implements StockDailyRepo {
  StockDailyRepoImpl(this._dailyDataSource);
  final DailyApiDataSource _dailyDataSource;

  final Map<String, List<DailyEntity>> dataStore = {};

  @override
  Future<List<DailyEntity>> getStoreData({
    required String stockCode,
    required DateTime startDateTime,
    required DateTime endDateTime,
  }) async {
    final stored = dataStore[stockCode];
    final hasStored = stored != null && stored.isNotEmpty;
    if (!hasStored) {
      final result = await _getStockDateData(
        stockCode: stockCode,
        needStartDateTime: startDateTime,
        endDateTime: endDateTime,
      );
      return result;
    } else if (!stored.first.date.isAfter(startDateTime)) {
      return stored
          .where((result) => !result.date.isBefore(startDateTime))
          .toList();
    } else {
      final needEndDateTime = stored[0].date.subtract(const Duration(days: 1));
      final result = await _getStockDateData(
        stockCode: stockCode,
        needStartDateTime: startDateTime,
        endDateTime: needEndDateTime,
      );
      return result;
    }
  }

  Future<List<DailyEntity>> _getStockDateData({
    required String stockCode,
    required DateTime needStartDateTime,
    required DateTime endDateTime,
  }) async {
    try {
      final fetchStartTime = needStartDateTime.subtract(
        const Duration(days: 7),
      );
      final response = await _dailyDataSource.stockDaily(
        stockCode,
        fetchStartTime,
        endDateTime,
      );
      final dataList = response;
      final entityList = <DailyEntity>[];
      for (var i = 1; i < response.length; i++) {
        final date = dataList[i].localDate;
        final data = dataList[i];
        final closePrice = data.closePrice.toInt();
        final prevClosePrice = dataList[i - 1].closePrice.toInt();
        final openPrice = dataList[i].openPrice.toInt();
        final highPrice = dataList[i].highPrice.toInt();
        final lowPrice = dataList[i].lowPrice.toInt();
        final volume = dataList[i].accumulatedTradingVolume.toInt();
        entityList.add(
          DailyEntity(
            date: DateTime.parse(date),
            openPrice: openPrice,
            highPrice: highPrice,
            lowPrice: lowPrice,
            closePrice: closePrice,
            volume: volume,
            change: closePrice - prevClosePrice,
          ),
        );
      }
      final stockStore = dataStore[stockCode];
      if (stockStore == null || stockStore.isEmpty) {
        dataStore.addAll({stockCode: entityList});
      } else {
        final preDataStore = stockStore;
        entityList.addAll(preDataStore);
        dataStore[stockCode] = entityList;
      }
      return entityList
          .where((result) => !result.date.isBefore(needStartDateTime))
          .toList();
    } catch (e) {
      throw toAppException(e);
    }
  }
}
