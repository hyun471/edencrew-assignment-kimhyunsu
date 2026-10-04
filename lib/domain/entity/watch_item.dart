import 'package:edencrew_assignment_starter/domain/entity/realtime_entity.dart';
import 'package:edencrew_assignment_starter/domain/entity/stock_entity.dart';

class WatchItem {
  WatchItem({required this.stock, required this.price});

  final StockEntity stock;
  final RealtimeEntity? price;
}
