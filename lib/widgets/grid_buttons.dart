import 'dart:ui';
import 'package:coin_log/layout.dart';
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
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: Layout.borderRadius.br,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: InkWell(
            borderRadius: Layout.borderRadius.br,
            onTap: onTap,
            child: Container(
              color: Colors.white.withOpacity(0.1),
              child: Icon(icon, weight: 200, size: 50, color: Colors.white),
            ),
          ),
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
