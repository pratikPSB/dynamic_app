import 'dart:developer';

import 'package:flutter/foundation.dart';

class Logger {
  static void doLog(dynamic val) {
    if (kDebugMode) {
      log(val.toString());
    }
  }
}
