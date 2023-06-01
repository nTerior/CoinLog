import 'package:coin_log/finance/transaction.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

const _transactionsBox = "transactions";

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

  final List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  void add(Transaction transaction) {
    _transactions.add(transaction);
    _balance += transaction.amount;
    notifyListeners();

    final box = Hive.box<Transaction>(_transactionsBox);
    box.add(transaction);
    box.flush();
  }

  void remove(Transaction transaction) {
    _transactions.remove(transaction);
    _balance -= transaction.amount;
    notifyListeners();

    transaction.delete();
  }

  void editTransaction(Transaction t) {
    notifyListeners();

    t.save();
  }

  Future<void> initFinances() async {
    final box = await Hive.openBox<Transaction>(_transactionsBox);
    for(final t in box.values) {
      _transactions.add(t);
      _balance += t.amount;
    }
  }
}
