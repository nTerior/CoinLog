import 'dart:ui';

import 'package:coin_log/layout.dart';
import 'package:flutter/material.dart';

class GlassMorphism extends StatelessWidget {
  final Widget child;

  const GlassMorphism({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: Layout.borderRadius.br,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: Layout.borderRadius.br,
            border: Border.fromBorderSide(
              BorderSide(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            color: Colors.white.withOpacity(0.1),
          ),
          child: child,
        ),
      ),
    );
  }
}
