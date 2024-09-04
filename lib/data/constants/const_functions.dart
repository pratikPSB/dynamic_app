import 'dart:ui';

import 'package:intl/intl.dart';

import '../utils/logger.dart';
import '../utils/prefs_utils.dart';
import 'const_keys.dart';

class ConstFunctions {
  static final _passwordRegEx =
      RegExp("^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@\u0024%^&*-]).{8,}\u0024");

  static bool isPasswordValid(String text) => _passwordRegEx.hasMatch(text);

  static enableHapticFeedback({bool isEnabled = true}) {
    Prefs().setBoolean(ConstKeys.prefHapticFeedbackEnabled, isEnabled);
  }

  static bool isHapticFeedbackEnabled() => Prefs().getBoolean(ConstKeys.prefHapticFeedbackEnabled);

  static String countryCodeToEmoji(String countryCode) {
    final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }

  static String getDateWithoutTime(String date) {
    final format = DateFormat('MM/dd/yyyy');
    try {
      final parsedDate = format.parse(date);
      return format.format(parsedDate);
    } catch (e) {
      Logger.doLog('Error parsing date: $e');
      return date;
    }
  }

  static TextStyle textStyle({
    double? size,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
    TextDecoration? decoration,
    double? letterSpacing,
  }) =>
      TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        decoration: decoration,
        letterSpacing: letterSpacing,
      );
}
