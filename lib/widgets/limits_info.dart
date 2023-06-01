import 'package:coin_log/finance/finance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LimitsInfo extends StatelessWidget {
  const LimitsInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final finance = context.watch<Finance>();

    return const Placeholder();
  }
}
