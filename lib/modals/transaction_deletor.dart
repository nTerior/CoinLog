import 'package:coin_log/finance/finance.dart';
import 'package:coin_log/finance/transaction.dart';
import 'package:coin_log/layout.dart';
import 'package:coin_log/widgets/grid_buttons.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class TransactionDeletorModal extends StatelessWidget {
  final Transaction transaction;

  const TransactionDeletorModal({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            text: "Do you really want to delete ",
            style: const TextStyle(fontWeight: FontWeight.w100),
            children: [
              TextSpan(
                text: transaction.title,
                style: const TextStyle(fontWeight: FontWeight.normal),
              ),
              const TextSpan(text: "?"),
            ],
          ),
        ),
        const SizedBox(height: Layout.padding),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 100,
              child: GridButton(
                text: "Delete",
                icon: Symbols.delete,
                textColor: Theme.of(context).colorScheme.error,
                iconColor: Theme.of(context).colorScheme.error,
                onTap: () {
                  Navigator.pop(context);
                  Provider.of<Finance>(context, listen: false)
                      .remove(transaction);
                },
              ),
            ),
            SizedBox(
              width: 100,
              child: GridButton(
                text: "Cancel",
                icon: Symbols.cancel,
                onTap: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: Layout.padding),
      ],
    );
  }
}
