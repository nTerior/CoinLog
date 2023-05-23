import 'package:coin_log/finance/finance.dart';
import 'package:coin_log/finance/transaction.dart';
import 'package:coin_log/pages/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl_standalone.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

final _finance = Finance();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    Wakelock.enable();
  }

  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  await _finance.initFinances();

  await findSystemLocale();
  runApp(const CoinLogApp());
}

class CoinLogApp extends StatelessWidget {
  const CoinLogApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _finance),
      ],
      child: MaterialApp(
        title: "CoinLog",
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        themeMode: ThemeMode.system,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.white,
            selectionColor: Colors.white.withOpacity(0.1),
            selectionHandleColor: Colors.white.withOpacity(0.5),
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white,
            brightness: Brightness.dark,
          ),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.white,
            selectionColor: Colors.white.withOpacity(0.1),
            selectionHandleColor: Colors.white.withOpacity(0.5),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
