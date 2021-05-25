// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class LanguageLocalization {
//   LanguageLocalization(this.locale);
//
//   final Locale locale;
//   static LanguageLocalization of(BuildContext context) {
//     return Localizations.of<LanguageLocalization>(context, LanguageLocalization);
//   }
//
//   Map<String, String> _localizedValues;
//
//   Future<void> load() async {
//     String jsonStringValues =
//     await rootBundle.loadString('lib/lang/${locale.languageCode}.json');
//     Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
//     _localizedValues =
//         mappedJson.map((key, value) => MapEntry(key, value.toString()));
//   }
//
//   String translate(String key) {
//     return _localizedValues[key];
//   }
//
//   // static member to have simple access to the delegate from Material App
//   static const LocalizationsDelegate<LanguageLocalization> delegate =
//   _LanguageLocalizationsDelegate();
// }
//
// class _LanguageLocalizationsDelegate
//     extends LocalizationsDelegate<LanguageLocalization> {
//   const _LanguageLocalizationsDelegate();
//
//   @override
//   bool isSupported(Locale locale) {
//     return ['en','ar'].contains(locale.languageCode);
//   }
//
//   @override
//   Future<LanguageLocalization> load(Locale locale) async {
//     LanguageLocalization localization = new LanguageLocalization(locale);
//     await localization.load();
//     return localization;
//   }
//
//   @override
//   bool shouldReload(LocalizationsDelegate<LanguageLocalization> old) => false;
// }