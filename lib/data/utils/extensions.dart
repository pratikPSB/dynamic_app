import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/const_functions.dart';

extension StringExtension on String {
  int getColorHexFromStr() {
    String colorStr = "FF$this";
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw const FormatException(
            "An error occurred when converting a color");
      }
    }
    return val;
  }
}

extension BorderModificatin on num {
  ShapeBorder modifyShapeBorder() {
    return RoundedRectangleBorder(borderRadius: modifyCorners());
  }

  BorderRadius modifyCorners() {
    return BorderRadius.all(Radius.circular(toDouble()));
  }
}

extension Go on BuildContext {
  Future<T?> to<T>(Widget page, {dynamic arguments}) async {
    return Navigator.push<T>(
      this,
      MaterialPageRoute(
        builder: (context) {
          return page;
        },
        settings: RouteSettings(arguments: arguments),
      ),
    );
  }

  Future<T?> toNamed<T>(String page, {dynamic arguments}) async {
    return Navigator.pushNamed(this, page, arguments: arguments);
  }

  Future<dynamic> off(Widget page, {dynamic arguments}) async {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute(
        builder: (context) {
          return page;
        },
        settings: RouteSettings(arguments: arguments),
      ),
    );
  }

  Future<dynamic> offNamed(String page, {dynamic arguments}) async {
    Navigator.pushReplacementNamed(this, page, arguments: arguments);
  }

  Future<dynamic> offAllNamed(String page, {dynamic arguments}) async {
    Navigator.pushNamedAndRemoveUntil(this, page, ModalRoute.withName('/'),
        arguments: arguments);
  }

  Future<dynamic> offUntil(String page) async {
    Navigator.popUntil(this, ModalRoute.withName(page));
  }

  Future<dynamic> pop() async {
    Navigator.pop(this);
  }

  ThemeData getTheme() {
    return Theme.of(this);
  }

  ColorScheme getColorScheme() {
    return Theme.of(this).colorScheme;
  }
}

performHapticFeedback() {
  if (ConstFunctions.isHapticFeedbackEnabled()) HapticFeedback.selectionClick();
}
