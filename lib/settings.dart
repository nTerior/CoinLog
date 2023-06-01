import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Settings extends ChangeNotifier {
  late final Box _box;

  // Limits
  bool _weeklyLimitEnabled = false;
  double? _weeklyLimit;

  bool _monthlyLimitEnabled = false;
  double? _monthlyLimit;

  bool _balanceLimitEnabled = false;
  double? _balanceLimit;

  bool get weeklyLimitEnabled => _weeklyLimitEnabled;

  double? get weeklyLimit => _weeklyLimit;

  bool get monthlyLimitEnabled => _monthlyLimitEnabled;

  double? get monthlyLimit => _monthlyLimit;

  bool get balanceLimitEnabled => _balanceLimitEnabled;

  double? get balanceLimit => _balanceLimit;

  set weeklyLimitEnabled(bool b) {
    _weeklyLimitEnabled = b;
    _box.put("weeklyLimitEnabled", b);
    notifyListeners();
  }

  set weeklyLimit(double? d) {
    _weeklyLimit = d;
    _box.put("weeklyLimit", d);
    notifyListeners();
  }

  set monthlyLimitEnabled(bool b) {
    _monthlyLimitEnabled = b;
    _box.put("monthlyLimitEnabled", b);
    notifyListeners();
  }

  set monthlyLimit(double? d) {
    _monthlyLimit = d;
    _box.put("monthlyLimit", d);
    notifyListeners();
  }

  set balanceLimitEnabled(bool b) {
    _balanceLimitEnabled = b;
    _box.put("balanceLimitEnabled", b);
    notifyListeners();
  }

  set balanceLimit(double? d) {
    _balanceLimit = d;
    _box.put("balanceLimit", d);
    notifyListeners();
  }

  Future<void> loadSettings() async {
    _box = await Hive.openBox("settings");

    // Limits
    _weeklyLimitEnabled = _box.get("weeklyLimitEnabled", defaultValue: false);
    _weeklyLimit = _box.get("weeklyLimit", defaultValue: null);

    _monthlyLimitEnabled = _box.get("monthlyLimitEnabled", defaultValue: false);
    _monthlyLimit = _box.get("monthlyLimit", defaultValue: null);

    _balanceLimitEnabled = _box.get("balanceLimitEnabled", defaultValue: false);
    _balanceLimit = _box.get("balanceLimit", defaultValue: null);
  }
}
