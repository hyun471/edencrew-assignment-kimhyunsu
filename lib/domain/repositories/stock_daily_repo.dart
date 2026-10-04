import 'package:edencrew_assignment_starter/domain/entity/daily_entity.dart';

abstract class StockDailyRepo {
  Future<List<DailyEntity>> getStockDateData({
    required String stockCode,
    required DateTime startDateTime,
    required DateTime endDateTime,
  });
}
