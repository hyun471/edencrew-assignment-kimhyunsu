import 'package:edencrew_assignment_starter/core/error/app_exception.dart';
import 'package:edencrew_assignment_starter/core/error/error_code.dart';
import 'package:edencrew_assignment_starter/data/data_source/detail_api_data_source.dart';
import 'package:edencrew_assignment_starter/data/data_source/search_api_data_source.dart';
import 'package:edencrew_assignment_starter/domain/entity/stock_entity.dart';
import 'package:edencrew_assignment_starter/domain/repositories/stock_repo.dart';

class StockRepoImpl implements StockRepo {
  const StockRepoImpl(this._detailDataSource, this._searchDataSource);
  final DetailApiDataSource _detailDataSource;
  final SearchApiDataSource _searchDataSource;

  @override
  Future<StockEntity> getStockData(String stockCode) async {
    try {
      final response = await _detailDataSource.stockDetail(stockCode);
      if (response.symbolCode.isEmpty || response.stockName.isEmpty) {
        throw const AppException(ErrorCode.parse);
      }
      final result = StockEntity(
        code: response.symbolCode,
        name: response.stockName,
        market: response.stockExchangeNameKor != ""
            ? response.stockExchangeNameKor
            : response.stockExchangeName,
      );
      return result;
    } catch (e) {
      throw toAppException(e);
    }
  }

  @override
  Future<List<StockEntity>> searchStocks(String inputText) async {
    try {
      if (inputText.isEmpty) return [];
      final response = await _searchDataSource.searchStocks(inputText);
      final result = response.items
          .where(
            (data) =>
                data.category == "stock" &&
                data.nationCode == "KOR" &&
                data.code.length == 6 &&
                data.name.isNotEmpty,
          )
          .map(
            (data) => StockEntity(
              code: data.code,
              name: data.name,
              market: data.typeName != "" ? data.typeName : data.typeCode,
            ),
          )
          .toList();
      return result;
    } catch (e) {
      throw toAppException(e);
    }
  }
}
