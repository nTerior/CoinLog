import 'package:camera/camera.dart';
import 'package:coin_log/scan/camera.dart';
import 'package:flutter/material.dart';

/// Initialized in main.dart
late final List<CameraDescription> cameras;

class ReceiptScanner extends StatelessWidget {
  const ReceiptScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scan Receipt",
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.w100,
              ),
        ),
      ),
      body: CameraPreview(cameraController!),
    );
  }
}
