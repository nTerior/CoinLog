import 'package:coin_log/finance/finance.dart';
import 'package:coin_log/morphism/glass_morphism.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final finance = context.watch<Finance>();
    final text = finance.transactions.isEmpty
        ? "No Transactions"
        : finance.transactions.length > 1
            ? "Last Transactions"
            : "Last Transaction";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w100,
              ),
        ),
        GlassMorphism(
          child: Column(
            children: finance.transactions,
          ),
        ),
      ],
    );
  }
}
