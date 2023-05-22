import 'package:coin_log/finance/transaction.dart';
import 'package:intl/intl.dart';

extension MoneyUtils on double {
  String asCurrency(String symbol) {
    return NumberFormat.currency(locale: Intl.systemLocale, symbol: symbol).format(this);
  }
}

class Finance {
  Finance._();

  static double balance = 0;
  static List<Transaction> transactions = [];
}