import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;
  int _hexOfCurrentPrimary;
  int _hexOfCurrentBackground;

  ThemeProvider() {
    _themeData = ThemeData.dark();
    _hexOfCurrentPrimary = 0xFF42A5F5;
    _hexOfCurrentBackground = 0xFF42A5F5;
    loadPreferences();
  }

  ThemeData get themeData => _themeData;
  int get hexOfCurrentPrimary => _hexOfCurrentPrimary;
  int get hexOfCurrentBackground => _hexOfCurrentBackground;

  void setHexCurrentBackground(int hexCurrentBackground) {
    _hexOfCurrentBackground = hexCurrentBackground;
  }

  void setHexCurrentPrimary(int hexCurrentPrimary) {
    _hexOfCurrentPrimary = hexCurrentPrimary;
  }

  void setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
    savePreferences();
  }

  void setPrimaryColor(Color primaryColor) {
    setHexCurrentPrimary(primaryColor.value);
    ThemeData _tempTheme = ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: primaryColor,
      brightness: _themeData.brightness,
      backgroundColor: _themeData.backgroundColor,
      accentColor: _themeData.accentColor,
      accentIconTheme: _themeData.accentIconTheme,
      dividerColor: _themeData.dividerColor,
    );
    setTheme(_tempTheme);
  }

  void setBackgroundColor(Color backgroundColor) {
    print('set background color called');
    setHexCurrentBackground(backgroundColor.value);
    ThemeData _tempTheme = ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: _themeData.primaryColor,
      brightness: _themeData.brightness,
      backgroundColor: _themeData.backgroundColor,
      accentColor: backgroundColor,
      accentIconTheme: _themeData.accentIconTheme,
      dividerColor: _themeData.dividerColor,
    );
    setTheme(_tempTheme);
  }

  savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('primaryHex', _hexOfCurrentPrimary);
    prefs.setInt('backgroundHex', _hexOfCurrentBackground);
  }

  loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int primaryHex = prefs.getInt('primaryHex');
    int backgroundHex = prefs.getInt('backgroundHex');
    if(primaryHex != null) setPrimaryColor(Color(primaryHex));
    if(backgroundHex != null) setBackgroundColor(Color(backgroundHex));
  }

}