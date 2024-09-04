import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  late SharedPreferences _prefs;
  static final Prefs _interface = Prefs._();

  factory Prefs() {
    return _interface;
  }

  Prefs._();

  initialize() async {
    await _initializePref();
  }

  _initializePref() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool contains(String key) {
    return _prefs.containsKey(key);
  }

  setString(String key, String value) {
    _prefs.setString(key, value);
  }

  String getString(String key) {
    return _prefs.getString(key) ?? "";
  }

  setInt(String key, int value) {
    _prefs.setInt(key, value);
  }

  int getInt(String key) {
    return _prefs.getInt(key) ?? 0;
  }

  void setDouble(String key, double value) {
    _prefs.setDouble(key, value);
  }

  double getDouble(String key) {
    return _prefs.getDouble(key) ?? 0;
  }

  setBoolean(String key, bool value) {
    _prefs.setBool(key, value);
  }

  bool getBoolean(String key) {
    return _prefs.getBool(key) ?? false;
  }

  clearAll() async {
    _prefs.clear();
  }

  setJson<T>(String key, T model) async {
    final json = jsonEncode(model);
    await _prefs.setString(key, json);
  }

  Map<String, dynamic> getJson<T>(String key) {
    final jsonString = _prefs.getString(key);
    if (jsonString == null) {
      throw Exception('No data found for key: $key');
    }
    return jsonDecode(jsonString);
  }
}
