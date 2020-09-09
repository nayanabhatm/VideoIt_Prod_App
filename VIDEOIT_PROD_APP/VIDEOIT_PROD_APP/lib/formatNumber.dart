import 'package:intl/intl.dart';

String formatNumber(int value) {
  return NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: ''
  ).format(value);
}