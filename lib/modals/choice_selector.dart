import 'package:coin_log/layout.dart';
import 'package:coin_log/widgets/grid_buttons.dart';
import 'package:flutter/material.dart';

class SelectorChoice<T> {
  final String name;
  final IconData icon;
  final T value;

  const SelectorChoice({
    required this.name,
    required this.icon,
    required this.value,
  });
}

class ChoiceSelectorModal extends StatelessWidget {
  final String text;
  final List<SelectorChoice> choices;

  const ChoiceSelectorModal(
      {Key? key, required this.text, required this.choices})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(text, style: const TextStyle(fontWeight: FontWeight.w100)),
        const SizedBox(height: Layout.padding),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: choices
              .map(
                (e) => SizedBox(
                  width: 100,
                  child: GridButton(
                    text: e.name,
                    icon: e.icon,
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
