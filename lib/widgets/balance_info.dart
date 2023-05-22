import 'package:coin_log/finance/finance.dart';
import 'package:coin_log/layout.dart';
import 'package:flutter/material.dart';

class BalanceInfo extends StatelessWidget {
  const BalanceInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Layout.padding.tlrPad,
      child: RichText(
        text: TextSpan(
          text: "Balance\n",
          children: [
            TextSpan(
              text: Finance.balance.asCurrency("€"),
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
