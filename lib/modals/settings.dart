import 'package:coin_log/layout.dart';
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
        const ToggleableSettingsInputTile(
          title: "Monthly Limit",
          initiallyEnabled: false,
          type: TextInputType.number,
          suffix: "€",
        ),
        const SizedBox(height: Layout.padding),
      ],
    );
  }
}
