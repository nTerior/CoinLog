import 'package:coin_log/finance/finance.dart';
import 'package:coin_log/finance/transaction.dart';
import 'package:coin_log/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class ExpenseLimit {
  String get name;

  double get limit;

  double calcRemainingLimit(List<Transaction> transactions);
}

abstract class TimelyExpenseLimit extends ExpenseLimit {
  DateTime getFirstIncludedDate();

  DateTime getLastIncludedDate();

  @override
  double calcRemainingLimit(List<Transaction> transactions) {
    final lastDate = getFirstIncludedDate();
    final remaining = transactions
        .where(
          (element) => element.amount < 0 && element.dateTime.isAfter(lastDate),
        )
        .map((e) => e.amount);

    if (remaining.isEmpty) {
      return limit;
    }

    final spent = remaining.reduce((value, element) => element + value);
    return limit + spent; // + since spent is negative
  }
}

class WeeklyExpenseLimit extends TimelyExpenseLimit {
  @override
  double get limit => _settings.monthlyLimit ?? 0;

  @override
  DateTime getFirstIncludedDate() {
    final now = DateTime.now().copyWith(hour: 0, minute: 0, second: 0);
    return now.subtract(Duration(days: now.weekday - 1));
  }

  @override
  DateTime getLastIncludedDate() {
    final now = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);
    return now.add(Duration(days: 7 - now.weekday));
  }

  @override
  String get name => "Weekly Expense Limit";
}

class MonthlyExpenseLimit extends TimelyExpenseLimit {
  @override
  double get limit => _settings.monthlyLimit ?? 0;

  @override
  DateTime getFirstIncludedDate() => DateTime.now().copyWith(
        day: 1,
        hour: 0,
        minute: 0,
        second: 0,
      );

  @override
  DateTime getLastIncludedDate() {
    final now = DateTime.now();
    return now.copyWith(
      day: 0,
      month: now.month + 1,
      hour: 23,
      minute: 59,
      second: 59,
    );
  }

  @override
  String get name => "Monthly Expense Limit";
}

class MinimumBalanceLimit extends ExpenseLimit {
  @override
  // ToDo
  double get limit => _settings.balanceLimit ?? 0;

  @override
  double calcRemainingLimit(List<Transaction> transactions) =>
      transactions.isEmpty
          ? -limit
          : transactions
                  .map((e) => e.amount)
                  .reduce((value, element) => element + value) -
              limit;

  @override
  String get name => "Minimum Balance Limit";
}

late Settings _settings;

class Limits {
  Limits._();

  static final monthlyLimit = MonthlyExpenseLimit();
  static final weeklyLimit = WeeklyExpenseLimit();
  static final minimumBalanceLimit = MinimumBalanceLimit();

  static void init(Settings s) {
    _settings = s;
  }

  /// Calculates if any limit will be exceeded when updating the balance with change
  static ({String? limit, double remaining}) willExceedAnyLimit(
      BuildContext context, double change) {
    final finance = Provider.of<Finance>(context, listen: false);

    final minBalanceRemain =
        minimumBalanceLimit.calcRemainingLimit(finance.transactions) + change;
    final weeklyRemain =
        weeklyLimit.calcRemainingLimit(finance.transactions) + change;
    final monthlyRemain =
        monthlyLimit.calcRemainingLimit(finance.transactions) + change;

    if (minBalanceRemain < 0) {
      return (limit: minimumBalanceLimit.name, remaining: minBalanceRemain);
    }
    if (weeklyRemain < 0) {
      return (limit: weeklyLimit.name, remaining: weeklyRemain);
    }
    if (monthlyRemain < 0) {
      return (limit: monthlyLimit.name, remaining: monthlyRemain);
    }
    return (limit: null, remaining: 0);
  }
}
