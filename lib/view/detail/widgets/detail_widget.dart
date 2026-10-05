import 'dart:math';

import 'package:edencrew_assignment_starter/domain/entity/daily_entity.dart';
import 'package:edencrew_assignment_starter/theme/theme.dart';
import 'package:flutter/material.dart';

// 캔들 차트: 패키지 대신 CustomPainter로 직접 그린다
class CandleChart extends StatelessWidget {
  const CandleChart({super.key, required this.dailyList});

  final List<DailyEntity> dailyList; // 오래된 날짜가 앞

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: CandlePainter(
        dailyList: dailyList,
        upColor: context.colors.chartLineUp,
        downColor: context.colors.chartLineDown,
        flatColor: context.colors.chartLineFlat,
      ),
    );
  }
}

class CandlePainter extends CustomPainter {
  CandlePainter({
    required this.dailyList,
    required this.upColor,
    required this.downColor,
    required this.flatColor,
  });

  final List<DailyEntity> dailyList;
  final Color upColor;
  final Color downColor;
  final Color flatColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (dailyList.isEmpty) return;

    // 기간 안의 최고가, 최저가로 세로 범위를 잡는다
    final maxPrice = dailyList.map((data) => data.highPrice).reduce(max);
    final minPrice = dailyList.map((data) => data.lowPrice).reduce(min);
    final priceRange = maxPrice - minPrice == 0 ? 1 : maxPrice - minPrice;

    // 캔들 하나가 차지하는 가로 폭
    final slotWidth = size.width / dailyList.length;
    final bodyWidth = (slotWidth * 0.6).clamp(1.0, 10.0);

    double priceToY(int price) {
      return size.height - (price - minPrice) / priceRange * size.height;
    }

    for (var i = 0; i < dailyList.length; i++) {
      final data = dailyList[i];
      final color = data.closePrice > data.openPrice
          ? upColor
          : data.closePrice < data.openPrice
          ? downColor
          : flatColor;
      final paint = Paint()..color = color;
      final centerX = slotWidth * i + slotWidth / 2;

      // 심지: 고가 ~ 저가
      canvas.drawLine(
        Offset(centerX, priceToY(data.highPrice)),
        Offset(centerX, priceToY(data.lowPrice)),
        paint..strokeWidth = 1,
      );

      // 몸통: 시가 ~ 종가 (보합이면 최소 1px)
      final top = priceToY(max(data.openPrice, data.closePrice));
      final bottom = priceToY(min(data.openPrice, data.closePrice));
      canvas.drawRect(
        Rect.fromLTRB(
          centerX - bodyWidth / 2,
          top,
          centerX + bodyWidth / 2,
          max(bottom, top + 1),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CandlePainter oldDelegate) {
    return oldDelegate.dailyList != dailyList;
  }
}
