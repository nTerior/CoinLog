import 'package:coin_log/layout.dart';
import 'package:coin_log/settings.dart';
import 'package:coin_log/widgets/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsModal extends StatelessWidget {
  const SettingsModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context, listen: false);

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowIndicator();
        return false;
      },
      child: ListView(
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
            initialValue: settings.balanceLimit,
            initiallyEnabled: settings.balanceLimitEnabled,
            onEdit: (value) => settings.balanceLimit =
                value.isNotEmpty ? double.parse(value) : null,
            onToggle: (value) => settings.balanceLimitEnabled = value,
          ),
          ToggleableSettingsInputTile(
            title: "Weekly Limit",
            suffix: "€",
            type: TextInputType.number,
            initialValue: settings.weeklyLimit,
            initiallyEnabled: settings.weeklyLimitEnabled,
            onEdit: (value) => settings.weeklyLimit =
                value.isNotEmpty ? double.parse(value) : null,
            onToggle: (value) => settings.weeklyLimitEnabled = value,
          ),
          ToggleableSettingsInputTile(
            title: "Monthly Limit",
            suffix: "€",
            type: TextInputType.number,
            initialValue: settings.monthlyLimit,
            initiallyEnabled: settings.monthlyLimitEnabled,
            onEdit: (value) => settings.monthlyLimit =
                value.isNotEmpty ? double.parse(value) : null,
            onToggle: (value) => settings.monthlyLimitEnabled = value,
          ),
          const SizedBox(height: Layout.padding),
        ],
      ),
    );
  }
}
