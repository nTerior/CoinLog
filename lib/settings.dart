import 'package:hive_flutter/hive_flutter.dart';

class Settings {
  static late final Box _box;

  // Limits
  static bool _weeklyLimitEnabled = false;
  static double? _weeklyLimit;

  static bool _monthlyLimitEnabled = false;
  static double? _monthlyLimit;

  static bool _balanceLimitEnabled = false;
  static double? _balanceLimit;

  static bool get weeklyLimitEnabled => _weeklyLimitEnabled;

  static double? get weeklyLimit => _weeklyLimit;

  static bool get monthlyLimitEnabled => _monthlyLimitEnabled;

  static double? get monthlyLimit => _monthlyLimit;

  static bool get balanceLimitEnabled => _balanceLimitEnabled;
  static double? get balanceLimit => _balanceLimit;

  static set weeklyLimitEnabled(bool b) {
    _weeklyLimitEnabled = b;
    _box.put("weeklyLimitEnabled", b);
  }

  static set weeklyLimit(double? d) {
    _weeklyLimit = d;
    _box.put("weeklyLimit", d);
  }

  static set monthlyLimitEnabled(bool b) {
    _monthlyLimitEnabled = b;
    _box.put("monthlyLimitEnabled", b);
  }

  static set monthlyLimit(double? d) {
    _monthlyLimit = d;
    _box.put("monthlyLimit", d);
  }

  static set balanceLimitEnabled(bool b) {
    _balanceLimitEnabled = b;
    _box.put("balanceLimitEnabled", b);
  }

  static set balanceLimit(double? d) {
    _balanceLimit = d;
    _box.put("balanceLimit", d);
  }

  static Future<void> loadSettings() async {
    _box = await Hive.openBox("settings");

    // Limits
    _weeklyLimitEnabled = _box.get("weeklyLimitEnabled", defaultValue: false);
    _weeklyLimit = _box.get("weeklyLimit", defaultValue: null);

    _monthlyLimitEnabled = _box.get("monthlyLimitEnabled", defaultValue: false);
    _monthlyLimit = _box.get("monthlyLimit", defaultValue: null);

    _balanceLimitEnabled = _box.get("balanceLimitEnabled", defaultValue: false);
    _balanceLimit = _box.get("balanceLimit", defaultValue: null);
  }

  Settings._();
}
