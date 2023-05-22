import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final ImageProvider image;
  final double opacity;

  const BackgroundImage({
    Key? key,
    required this.image,
    this.opacity = 0.6,
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
      child: Container(color: Colors.black.withOpacity(opacity)),
    );
  }
}
