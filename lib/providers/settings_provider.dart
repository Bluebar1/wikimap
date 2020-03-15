import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wiki_map/providers/theme_provider.dart';


class SettingsProvider with ChangeNotifier{
  String _units;
  List<String> _waxLines;
  List<String> _speedString;
  int _speedSelect;
  Color _themeColor;
  Color _accentColor;
  //TODO add custom theme color setting

  SettingsProvider(ThemeProvider themeProvider) {
    _units='Imperial';
    _waxLines = ['Swix','Toko'];
    _speedSelect = 1;
    _speedString = ['Slow','Medium','Fast'];
    _themeColor = Color(themeProvider.hexOfCurrentPrimary);
    _accentColor = Color(themeProvider.hexOfCurrentBackground);
    loadPreferences();
  }

  String get units => _units;
  List<String> get waxLines => _waxLines;
  int get speedSelect => _speedSelect;
  List<String> get speedString => _speedString;
  Color get themeColor => _themeColor;
  Color get accentColor => _accentColor;

  void setAccentColor(Color accentColor) {
    print('set accent color called');
    _accentColor = accentColor;
    notifyListeners();
    savePreferences();
  }

  void setThemeColor(Color themeColor) {
    print('SET THEME COLOR CALLED');
    _themeColor = themeColor;
    notifyListeners();
    savePreferences();
  }

  void setUnits(String units) {
    _units = units;
    notifyListeners();
    savePreferences();
  }

  void setSpeedSelect(int speedSelect) {
    _speedSelect = speedSelect;
    notifyListeners();
    savePreferences();
  }

  void _setWaxLines(List<String> waxLines) {
    _waxLines = waxLines;
    notifyListeners();
  }

  void addWaxLine(String waxLine) {
    if (_waxLines.contains(waxLine) == false) {
      _waxLines.add(waxLine);
      notifyListeners();
      savePreferences();
    }
  }

  void removeWaxLine(String waxLine) {
    if (_waxLines.contains(waxLine) == true) {
      _waxLines.remove(waxLine);
      notifyListeners();
      savePreferences();
    }
  }

  savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('units', _units);
    prefs.setStringList('waxLines', _waxLines);
    prefs.setInt('speedSelect', _speedSelect);
  }

  loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String units = prefs.getString('units');
    List<String> waxLines = prefs.getStringList('waxLines');
    int speedSelect = prefs.getInt('speedSelect');

    if (units != null) setUnits(units);
    if (waxLines != null) _setWaxLines(waxLines);
    if (speedSelect != null) setSpeedSelect(speedSelect);
  }

}