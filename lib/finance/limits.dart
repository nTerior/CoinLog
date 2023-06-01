import 'package:coin_log/finance/transaction.dart';
import 'package:coin_log/settings.dart';

abstract class ExpenseLimit {
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
    final now = DateTime.now();
    return now.subtract(Duration(days: now.weekday - 1));
  }

  @override
  DateTime getLastIncludedDate() {
    final now = DateTime.now();
    return now.add(Duration(days: 7 - now.weekday));
  }
}

class MonthlyExpenseLimit extends TimelyExpenseLimit {
  @override
  double get limit => _settings.monthlyLimit ?? 0;

  @override
  DateTime getFirstIncludedDate() => DateTime.now().copyWith(day: 1);

  @override
  DateTime getLastIncludedDate() {
    final now = DateTime.now();
    return now.copyWith(day: 0, month: now.month + 1);
  }
}

class MinimumBalanceLimit extends ExpenseLimit {
  @override
  // ToDo
  double get limit => _settings.balanceLimit ?? 0;

  @override
  double calcRemainingLimit(List<Transaction> transactions) =>
      transactions.isEmpty
          ? limit
          : limit -
              transactions
                  .map((e) => e.amount)
                  .reduce((value, element) => element + value);
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
}
