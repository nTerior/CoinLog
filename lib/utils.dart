import 'package:coin_log/layout.dart';
import 'package:coin_log/morphism/glass_morphism.dart';
import 'package:flutter/material.dart';

void openModal(BuildContext context, Widget modal) {
  showModalBottomSheet(
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
      child: GlassMorphism(
        bottomBorderWidth: 0,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(Layout.borderRadius),
          bottom: Radius.zero,
        ),
        padding: Layout.padding.pad,
        child: modal,
      ),
    ),
  );
}
