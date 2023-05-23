import 'package:coin_log/layout.dart';
import 'package:coin_log/settings.dart';
import 'package:coin_log/widgets/settings_tile.dart';
import 'package:flutter/material.dart';

class SettingsModal extends StatelessWidget {
  const SettingsModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Text(
          "Settings",
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.w100,
              ),
        ),
        Divider(color: Colors.white.withOpacity(0.1)),
        const Text("Limits", style: TextStyle(fontWeight: FontWeight.w100)),
        ToggleableSettingsInputTile(
          title: "Total Balance Limit",
          suffix: "€",
          type: TextInputType.number,
          initialValue: Settings.balanceLimit,
          initiallyEnabled: Settings.balanceLimitEnabled,
          onEdit: (value) => Settings.balanceLimit =
              value.isNotEmpty ? double.parse(value) : null,
          onToggle: (value) => Settings.balanceLimitEnabled = value,
        ),
        ToggleableSettingsInputTile(
          title: "Weekly Limit",
          suffix: "€",
          type: TextInputType.number,
          initialValue: Settings.weeklyLimit,
          initiallyEnabled: Settings.weeklyLimitEnabled,
          onEdit: (value) => Settings.weeklyLimit =
              value.isNotEmpty ? double.parse(value) : null,
          onToggle: (value) => Settings.weeklyLimitEnabled = value,
        ),
        ToggleableSettingsInputTile(
          title: "Monthly Limit",
          suffix: "€",
          type: TextInputType.number,
          initialValue: Settings.monthlyLimit,
          initiallyEnabled: Settings.monthlyLimitEnabled,
          onEdit: (value) => Settings.monthlyLimit =
              value.isNotEmpty ? double.parse(value) : null,
          onToggle: (value) => Settings.monthlyLimitEnabled = value,
        ),
        const SizedBox(height: Layout.padding),
      ],
    );
  }
}
