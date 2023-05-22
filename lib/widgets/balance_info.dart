import 'package:coin_log/finance/finance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BalanceInfo extends StatelessWidget {
  const BalanceInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final finance = context.watch<Finance>();

    return RichText(
      text: TextSpan(
        text: "Balance\n",
        children: [
          TextSpan(
            text: finance.balance.asCurrency("€"),
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w100,
                ),
          ),
        ],
      ),
    );
  }
}
