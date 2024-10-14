import 'package:flutter/cupertino.dart';

class FallbackCupertinoLocalizationDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) async => const DefaultCupertinoLocalizations();

  @override
  bool shouldReload(_) => false;
}
