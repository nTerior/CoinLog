import 'package:coin_log/finance/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension MoneyUtils on double {
  String asCurrency(String symbol) {
    return NumberFormat.currency(locale: Intl.systemLocale, symbol: symbol)
        .format(this);
  }
}

class Finance extends ChangeNotifier {
  double _balance = 0;

  double get balance => _balance;

  set balance(double b) {
    _balance = b;
    notifyListeners();
  }

  final List<Transaction> _transactions = [
    Transaction(title: "1. Handy", amount: -500, dateTime: DateTime.now().subtract(const Duration(days: 4))),
    Transaction(title: "1. Handy", amount: -500, dateTime: DateTime.now().subtract(const Duration(days: 4))),
    Transaction(title: "1. Handy", amount: -500, dateTime: DateTime.now().subtract(const Duration(days: 4))),
    Transaction(title: "1. Handy", amount: -500, dateTime: DateTime.now().subtract(const Duration(days: 4))),
    Transaction(title: "1. Handy", amount: -500, dateTime: DateTime.now().subtract(const Duration(days: 4))),
    Transaction(title: "1. Handy", amount: -500, dateTime: DateTime.now().subtract(const Duration(days: 4))),
    Transaction(title: "1. Handy", amount: -500, dateTime: DateTime.now().subtract(const Duration(days: 4))),
    Transaction(title: "2. Handy", amount: 500, dateTime: DateTime.now().subtract(const Duration(days: 3))),
    Transaction(title: "3. Handy", amount: -500, dateTime: DateTime.now().subtract(const Duration(days: 2))),
    Transaction(title: "4. Handy", amount: 500, dateTime: DateTime.now().subtract(const Duration(days: 1))),
    Transaction(title: "5. Handy", amount: -500, dateTime: DateTime.now()),
  ];

  List<Transaction> get transactions => _transactions;

  void add(Transaction transaction) {
    _transactions.add(transaction);
    _balance += transaction.amount;
    notifyListeners();
  }

  void remove(Transaction transaction) {
    _transactions.remove(transaction);
    _balance -= transaction.amount;
    notifyListeners();
  }

  void editTransaction(Transaction old, Transaction values) {
    final index = _transactions.indexOf(old);
    _transactions.remove(old);
    _transactions.insert(index, values);
    notifyListeners();
  }
}
