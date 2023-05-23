import 'package:coin_log/layout.dart';
import 'package:coin_log/modals/choice_selector.dart';
import 'package:coin_log/modals/settings.dart';
import 'package:coin_log/modals/transaction_editor.dart';
import 'package:coin_log/morphism/glass_morphism.dart';
import 'package:coin_log/scan/receipt_scanner.dart';
import 'package:coin_log/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class GridButtons extends StatelessWidget {
  const GridButtons({Key? key}) : super(key: key);

  void handleScanClick(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
          appBar: AppBar(
            title: Text(
              "Receipt Scanner",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.w100),
            ),
          ),
          body: Center(
            child: Text(
              "Coming soon!",
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w100,
                  ),
            ),
          ),
        ),
      ),
    );
    return;
    // ToDo finalize scanner
    final result = await openModal<ImageSource>(
      context,
      const ChoiceSelectorModal(
        text: "Scan receipt from:",
        choices: [
          SelectorChoice(
            name: "Camera",
            icon: Symbols.camera,
            value: ImageSource.camera,
          ),
          SelectorChoice(
            name: "Gallery",
            icon: Symbols.gallery_thumbnail,
            value: ImageSource.gallery,
          ),
        ],
      ),
    );
    if (result == null) return;

    final image = await ImagePicker().pickImage(source: result);
    if (image == null) return;

    final texts = await scanImage(image.path);

    // Image has been picked
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReceiptScanner(texts: texts),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final children = [
      GridButton(
        text: "Add",
        icon: Symbols.add_rounded,
        onTap: () => openModal(context, const TransactionEditorSheet()),
      ),
      GridButton(
        text: "Scan",
        icon: Symbols.scan,
        onTap: () => handleScanClick(context),
      ),
      Container(height: 1),
      GridButton(
        text: "Settings",
        icon: Symbols.settings,
        onTap: () => openModal(context, const SettingsModal()),
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
