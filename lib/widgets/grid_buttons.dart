import 'package:coin_log/layout.dart';
import 'package:coin_log/morphism/glass_morphism.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onTap;

  const GridButton({
    Key? key,
    required this.text,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: GlassMorphism(
              child: Icon(icon, weight: 200, size: 50, color: Colors.white),
            ),
          ),
          const SizedBox(height: Layout.padding / 2),
          Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class GridButtons extends StatelessWidget {
  const GridButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const children = [
      GridButton(text: "Add", icon: Symbols.add_rounded),
      GridButton(text: "Stats", icon: Symbols.donut_large_rounded),
      GridButton(text: "Limits", icon: Symbols.filter_none_rounded),
      GridButton(text: "Settings", icon: Symbols.settings),
    ];

    return MasonryGridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      crossAxisSpacing: Layout.padding,
      itemCount: 4,
      itemBuilder: (context, index) => children[index],
    );
  }
}
