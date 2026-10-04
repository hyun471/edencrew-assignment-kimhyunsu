import 'package:edencrew_assignment_starter/core/error/app_exception.dart';
import 'package:edencrew_assignment_starter/data/data_source/realtime_api_data_source.dart';
import 'package:edencrew_assignment_starter/domain/entity/price_direction.dart';
import 'package:edencrew_assignment_starter/domain/entity/realtime_entity.dart';
import 'package:edencrew_assignment_starter/domain/repositories/realtime_repo.dart';

class RealtimeRepoImpl implements RealtimeRepo {
  const RealtimeRepoImpl(this._realtimeDataSource);
  final RealtimeApiDataSource _realtimeDataSource;
  @override
  Future<Map<String, RealtimeEntity>> getRealtimeData(
    List<String> stockCodeList,
  ) async {
    try {
      if (stockCodeList.isEmpty) return {};
      final response = await _realtimeDataSource.realtimeStocksList(
        stockCodeList,
      );
      final result = {
        for (final data in response)
          data.cd: RealtimeEntity(
            code: data.cd,
            currentPrice: data.nv,
            previousClose: data.pcv,
            openPrice: data.ov,
            highPrice: data.hv,
            lowPrice: data.lv,
            volume: data.aq,
            listedShares: data.countOfListedStock,
            change: data.nv - data.pcv,
            changeRate: data.pcv == 0 ? 0 : (data.nv - data.pcv) / data.pcv,
            marketCap: data.nv * data.countOfListedStock,
            direction: data.nv - data.pcv > 0
                ? PriceDirection.up
                : data.nv - data.pcv < 0
                ? PriceDirection.down
                : PriceDirection.flat,
          ),
      };
      return result;
    } catch (e) {
      throw toAppException(e);
    }
  }
}
