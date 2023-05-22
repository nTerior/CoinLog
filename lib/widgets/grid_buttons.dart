import 'dart:ui';
import 'package:coin_log/layout.dart';
import 'package:coin_log/morphism/glass_morphism.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class GridButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onTap;

  const GridButton({
    Key? key,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1,
        child: GlassMorphism(
          child: Icon(icon, weight: 200, size: 50, color: Colors.white),
        ),
      ),
    );
  }
}

class GridButtons extends StatelessWidget {
  const GridButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      crossAxisSpacing: Layout.padding,
      children: const [
        GridButton(icon: Symbols.add_rounded),
        GridButton(icon: Symbols.donut_large_rounded),
        GridButton(icon: Symbols.filter_none_rounded),
        GridButton(icon: Symbols.settings),
        Text(
          "Add",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        Text(
          "Statistics",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        Text(
          "Limits",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        Text(
          "Settings",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
