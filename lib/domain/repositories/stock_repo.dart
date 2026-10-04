import 'package:edencrew_assignment_starter/domain/entity/stock_entity.dart';

abstract class StockRepo {
  Future<StockEntity> getStockData(String stockCode);
  Future<List<StockEntity>> searchStocks(String inputText);
}
