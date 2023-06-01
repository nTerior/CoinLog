import 'package:coin_log/layout.dart';
import 'package:coin_log/modals/choice_selector.dart';
import 'package:coin_log/modals/settings.dart';
import 'package:coin_log/modals/transaction_editor.dart';
import 'package:coin_log/morphism/glass_morphism.dart';
import 'package:coin_log/pages/receipt_scanner.dart';
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
      mainAxisSize: MainAxisSize.min,
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
    final url = await getWorkingReceiptScannerUrl();
    if (url == null) {
      if (context.mounted) {
        openModal(
          context,
          const ChoiceSelectorModal(
            text:
                "An internet connection is required in order to use the receipt scanner!",
            choices: [
              SelectorChoice(name: "Close", icon: Symbols.close, value: null),
            ],
          ),
        );
      }
      return;
    }

    if (context.mounted) {
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

      final request = await buildRequest(url, image.path);

      if (context.mounted) {
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) =>
                ReceiptScannerPage(request: request),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              final tween = Tween(begin: begin, end: end);
              final offsetAnimation = animation.drive(
                tween.chain(
                  CurveTween(
                    curve: Curves.ease,
                  ),
                ),
              );
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        );
      }
    }
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
