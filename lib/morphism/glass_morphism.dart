import 'dart:ui';

import 'package:coin_log/layout.dart';
import 'package:flutter/material.dart';
import 'package:non_uniform_border/non_uniform_border.dart';

class GlassMorphism extends StatelessWidget {
  final Widget? child;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;

  final double topBorderWidth;
  final double leftBorderWidth;
  final double rightBorderWidth;
  final double bottomBorderWidth;

  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const GlassMorphism({
    Key? key,
    this.child,
    this.borderRadius,
    this.border,
    this.topBorderWidth = 1,
    this.leftBorderWidth = 1,
    this.rightBorderWidth = 1,
    this.bottomBorderWidth = 1,
    this.width,
    this.height,
    this.padding,
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
              topWidth: topBorderWidth,
              leftWidth: leftBorderWidth,
              rightWidth: rightBorderWidth,
              bottomWidth: bottomBorderWidth,
              borderRadius: borderRadius ?? Layout.borderRadius.br,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          width: width,
          height: height,
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
