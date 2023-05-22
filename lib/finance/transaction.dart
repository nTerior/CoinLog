import 'dart:ui';

import 'package:coin_log/finance/finance.dart';
import 'package:coin_log/layout.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateUtils on DateTime {
  String get formatted {
    return DateFormat.yMMMd(Intl.systemLocale)
        .addPattern(DateFormat.HOUR24_MINUTE, " • ")
        .format(this);
  }
}

class Transaction extends StatelessWidget {
  final String title;
  final double amount;
  final DateTime dateTime;

  const Transaction({
    super.key,
    required this.title,
    required this.amount,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Layout.padding.pad,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                dateTime.formatted,
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
          Text(
            "${amount >= 0 ? "+" : ""}${amount.asCurrency("€")}",
            style: TextStyle(
              color: amount < 0 ? Colors.red : Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
