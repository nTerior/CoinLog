import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final ImageProvider image;
  final double opacity;
  final double blur;

  const BackgroundImage({
    Key? key,
    required this.image,
    this.opacity = 0.7,
    this.blur = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(color: Colors.black.withOpacity(opacity)),
      ),
    );
  }
}
