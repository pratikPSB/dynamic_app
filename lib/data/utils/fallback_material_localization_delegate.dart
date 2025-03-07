import 'package:flutter/material.dart';

class FallbackMaterialLocalizationDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<MaterialLocalizations> load(Locale locale) async => const DefaultMaterialLocalizations();

  @override
  bool shouldReload(_) => false;
}
