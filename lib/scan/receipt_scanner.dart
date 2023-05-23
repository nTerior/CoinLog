import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

Future<RecognizedText> scanImage(String path) async {
  return await TextRecognizer().processImage(InputImage.fromFilePath(path));
}

final _random = Random();

class ReceiptScanner extends StatefulWidget {
  final RecognizedText texts;

  const ReceiptScanner({Key? key, required this.texts}) : super(key: key);

  @override
  State<ReceiptScanner> createState() => _ReceiptScannerState();
}

class _ReceiptScannerState extends State<ReceiptScanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scanned Receipt",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.w100),
        ),
      ),
      body: ListView(
        children: widget.texts.blocks
            .map(
              (e) => Container(
                color:
                    Colors.primaries[_random.nextInt(Colors.primaries.length)],
                child: Column(
                  children: [
                    Text(e.cornerPoints.join(",")),
                    ...e.lines.map(
                      (e) => Text(
                        e.text,
                        style: TextStyle(
                          color: Colors.primaries[
                              _random.nextInt(Colors.primaries.length)],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
