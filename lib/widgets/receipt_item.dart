import 'package:coin_log/finance/finance.dart';
import 'package:coin_log/receipt/receipt_item.dart';
import 'package:flutter/material.dart';

class ReceiptItemWidget extends StatelessWidget {
  final ReceiptItem item;

  const ReceiptItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(item.description ?? "Item"),
        Text(item.amount!.asCurrency("€")),
      ],
    );
  }
}
