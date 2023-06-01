import 'package:coin_log/layout.dart';
import 'package:coin_log/widgets/grid_buttons.dart';
import 'package:flutter/material.dart';

class SelectorChoice<T> {
  final String name;
  final IconData icon;
  final Color? color;
  final T value;

  const SelectorChoice({
    required this.name,
    required this.icon,
    this.color,
    required this.value,
  });
}

class ChoiceSelectorModal extends StatelessWidget {
  final TextSpan text;
  final List<SelectorChoice> choices;

  const ChoiceSelectorModal(
      {Key? key, required this.text, required this.choices})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: text,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Layout.padding),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: choices
              .map(
                (e) => SizedBox(
                  width: 100,
                  child: GridButton(
                    text: e.name,
                    textColor: e.color,
                    icon: e.icon,
                    iconColor: e.color,
                    onTap: () => Navigator.pop(context, e.value),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: Layout.padding),
      ],
    );
  }
}
