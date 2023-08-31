import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/app_theme.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;
  bool _themeIsMedi;

  final SharedPreferences _prefs;

  ThemeChanger(this._themeData, this._themeIsMedi, this._prefs);

  ThemeData getTheme() => _themeData;
  bool getThemeIsMedi() => _themeIsMedi;

  Future<void> setTheme(ThemeData theme) async {
    _themeData = theme;
    _themeIsMedi = _themeData == AppTheme.mediTheme;

    await _prefs.setInt('themeIndex', _themeIsMedi ? 0 : 1);

    notifyListeners();
  }

  static Future<ThemeChanger> create(SharedPreferences prefs) async {
    final themeIndex = prefs.getInt('themeIndex') ?? 0;
    final initialTheme =
        themeIndex == 0 ? AppTheme.mediTheme : AppTheme.ecoTheme;
    final initialThemeIsMedi = themeIndex == 0;

    return ThemeChanger(initialTheme, initialThemeIsMedi, prefs);
  }
}
