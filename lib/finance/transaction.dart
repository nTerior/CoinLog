import 'package:coin_log/finance/finance.dart';
import 'package:coin_log/layout.dart';
import 'package:coin_log/modals/transaction_deletor.dart';
import 'package:coin_log/modals/transaction_editor.dart';
import 'package:coin_log/utils.dart';
import 'package:coin_log/widgets/custom_slidable_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

part 'transaction.g.dart';

extension DateUtils on DateTime {
  String get formatDate => DateFormat.yMMMd(Intl.systemLocale).format(this);

  String get formatTime => DateFormat.Hm(Intl.systemLocale).format(this);
}

@HiveType(typeId: 0)
class Transaction {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late double amount;

  @HiveField(2)
  late DateTime dateTime;

  late int boxIndex;

  Widget get widget => TransactionWidget(transaction: this);
}

class TransactionWidget extends StatelessWidget {
  final Transaction transaction;

  const TransactionWidget({
    super.key, required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          VerticalDivider(
            color: Colors.white.withOpacity(0.1),
          ),
          MySlidableAction(
            backgroundColor: Colors.transparent,
            onPressed: (context) => openModal(
              context,
              TransactionEditorSheet(
                transaction: transaction,
              ),
            ),
            icon: const Icon(Symbols.edit, fill: 1),
          ),
          MySlidableAction(
            backgroundColor: Colors.transparent,
            onPressed: (context) => openModal(
              context,
              TransactionDeletorModal(
                transaction: transaction,
              ),
            ),
            icon: Icon(
              Symbols.delete,
              fill: 1,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
      child: Padding(
        padding: Layout.padding.pad,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(color: Colors.white),
                ),
                Row(
                  children: [
                    Text(
                      transaction.dateTime.formatDate,
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
                      transaction.dateTime.formatTime,
                      style: const TextStyle(
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Text(
              "${transaction.amount >= 0 ? "+" : ""}${transaction.amount.asCurrency("€")}",
              style: TextStyle(
                color: transaction.amount < 0
                    ? Theme.of(context).colorScheme.error
                    : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
