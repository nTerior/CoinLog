import 'package:coin_log/layout.dart';
import 'package:coin_log/modals/add_transaction.dart';
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
              child: Icon(icon, weight: 100, size: 50, color: Colors.white),
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
    final children = [
      GridButton(
        text: "Add",
        icon: Symbols.add_rounded,
        onTap: () => showModalBottomSheet(
          context: context,
          elevation: 0,
          backgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(Layout.borderRadius),
              bottom: Radius.zero,
            ),
          ),
          builder: (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: const AddTransactionSheet(),
          ),
        ),
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
