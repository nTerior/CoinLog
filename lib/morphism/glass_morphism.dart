import 'dart:ui';

import 'package:coin_log/layout.dart';
import 'package:flutter/material.dart';
import 'package:non_uniform_border/non_uniform_border.dart';

class GlassMorphism extends StatelessWidget {
  final Widget child;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;

  final double topWidth;
  final double leftWidth;
  final double rightWidth;
  final double bottomWidth;

  const GlassMorphism({
    Key? key,
    required this.child,
    this.borderRadius,
    this.border,
    this.topWidth = 1,
    this.leftWidth = 1,
    this.rightWidth = 1,
    this.bottomWidth = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? Layout.borderRadius.br,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: ShapeDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: NonUniformBorder(
              topWidth: topWidth,
              leftWidth: leftWidth,
              rightWidth: rightWidth,
              bottomWidth: bottomWidth,
              borderRadius: borderRadius ?? Layout.borderRadius.br,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
