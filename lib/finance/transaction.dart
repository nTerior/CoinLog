import 'package:coin_log/finance/finance.dart';
import 'package:coin_log/layout.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateUtils on DateTime {
  String get formatDate => DateFormat.yMMMd(Intl.systemLocale).format(this);

  String get formatTime => DateFormat.Hm(Intl.systemLocale).format(this);
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
              Row(
                children: [
                  Text(
                    dateTime.formatDate,
                    style: const TextStyle(
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  Padding(
                    padding: (Layout.padding / 4).hPad,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.7),
                      ),
                      width: 4,
                      height: 4,
                    ),
                  ),
                  Text(
                    dateTime.formatTime,
                    style: const TextStyle(
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ],
              )
            ],
          ),
          Text(
            "${amount >= 0 ? "+" : ""}${amount.asCurrency("€")}",
            style: TextStyle(
              color: amount < 0
                  ? Theme.of(context).colorScheme.error
                  : Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
