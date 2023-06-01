import 'package:coin_log/finance/finance.dart';
import 'package:coin_log/finance/limits.dart';
import 'package:coin_log/layout.dart';
import 'package:coin_log/morphism/glass_morphism.dart';
import 'package:coin_log/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LimitsInfo extends StatelessWidget {
  const LimitsInfo({Key? key}) : super(key: key);

  Widget limitInfo(BuildContext context, String text, double remaining) =>
      RichText(
        text: TextSpan(
          text: "$text\n",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w100,
              ),
          children: [
            TextSpan(
              text: remaining.asCurrency("€"),
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: remaining >= 0
                        ? Colors.white
                        : Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.w100,
                  ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<Settings>();
    final finance = context.watch<Finance>();

    final remaningMonthlyLimit = Limits.monthlyLimit.calcRemainingLimit(
      finance.transactions,
    );
    final remaningWeeklyLimit = Limits.weeklyLimit.calcRemainingLimit(
      finance.transactions,
    );

    if (!settings.balanceLimitEnabled && !settings.weeklyLimitEnabled && !settings.monthlyLimitEnabled) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: Layout.padding.tPad,
      child: GlassMorphism(
        padding: Layout.padding.pad,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (settings.monthlyLimitEnabled)
              limitInfo(
                context,
                "Monthly Limit",
                remaningMonthlyLimit,
              ),
            if (settings.weeklyLimitEnabled)
              limitInfo(
                context,
                "Weekly Limit",
                remaningWeeklyLimit,
              ),
          ],
        ),
      ),
    );
  }
}
