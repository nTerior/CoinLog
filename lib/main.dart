import 'package:coin_log/pages/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

void main() {
  if (kDebugMode) {
    WidgetsFlutterBinding.ensureInitialized();
    Wakelock.enable();
  }

  runApp(const CoinLogApp());
}

class CoinLogApp extends StatelessWidget {
  const CoinLogApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CoinLog",
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
