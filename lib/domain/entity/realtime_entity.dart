import 'package:edencrew_assignment_starter/domain/entity/price_direction.dart';

class RealtimeEntity {
  RealtimeEntity({
    required this.code,
    required this.currentPrice,
    required this.previousClose,
    required this.openPrice,
    required this.highPrice,
    required this.lowPrice,
    required this.volume,
    required this.listedShares,
    required this.change,
    required this.changeRate,
    required this.marketCap,
    required this.direction,
  });

  final String code;
  final int currentPrice;
  final int previousClose;
  final int openPrice;
  final int highPrice;
  final int lowPrice;
  final int volume;
  final int listedShares;
  final int change;
  final double changeRate;
  final int marketCap;
  final PriceDirection direction;
}
