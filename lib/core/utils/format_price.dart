class FormatPrice {
  static String comma(num value) {
    final digits = value.abs().toStringAsFixed(0);
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(',');
      buffer.write(digits[i]);
    }
    return value < 0 ? '-$buffer' : buffer.toString();
  }

  static String change(int change, double rate) {
    final sign = change > 0 ? '+' : (change < 0 ? '-' : '');
    final percent = (rate.abs() * 100).toStringAsFixed(2);
    return '$sign${comma(change.abs())} ($sign$percent%)';
  }

  // 일별 시세 표의 등락: +1,200 / -400 / 0
  static String signed(int value) {
    final sign = value > 0 ? '+' : '';
    return '$sign${comma(value)}';
  }

  // 상세 헤더의 등락: ▲ 1,200 (+0.67%) / ▼ 400 (-0.22%) / 0 (0.00%)
  static String arrowChange(int change, double rate) {
    final arrow = change > 0 ? '▲ ' : (change < 0 ? '▼ ' : '');
    final sign = change > 0 ? '+' : (change < 0 ? '-' : '');
    final percent = (rate.abs() * 100).toStringAsFixed(2);
    return '$arrow${comma(change.abs())} ($sign$percent%)';
  }

  static String volume(int value) {
    if (value < 1000) return comma(value);
    return '${comma(value ~/ 1000)}천';
  }

  static String marketCap(int value) {
    const jo = 1000000000000; // 1조
    const eok = 100000000; // 1억
    if (value >= jo) return '${comma(value ~/ jo)}조';
    return '${comma(value ~/ eok)}억';
  }
}
