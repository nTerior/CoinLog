import 'package:coin_log/layout.dart';
import 'package:coin_log/modals/transaction_editor.dart';
import 'package:coin_log/morphism/glass_morphism.dart';
import 'package:coin_log/utils.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function() onTap;

  final Color? textColor;
  final Color? iconColor;

  const GridButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.textColor,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlassMorphismButton(
          onPressed: onTap,
          child: AspectRatio(
            aspectRatio: 1,
            child: Icon(
              icon,
              weight: 100,
              size: 50,
              color: iconColor ?? Colors.white,
            ),
          ),
        ),
        const SizedBox(height: Layout.padding / 2),
        Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
          ),
        ),
      ],
    );
  }
}

class GridButtons extends StatelessWidget {
  const GridButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = [
      GridButton(
        text: "Add",
        icon: Symbols.add_rounded,
        onTap: () => openModal(context, const TransactionEditorSheet()),
      ),
      Container(height: 1),
      Container(height: 1),
      GridButton(
        text: "Settings",
        icon: Symbols.settings,
        onTap: () {},
      ),
    ];

    return MasonryGridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      crossAxisSpacing: Layout.padding,
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}
