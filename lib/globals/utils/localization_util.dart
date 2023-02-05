import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/globals/localizations/languages/en.dart';
import 'package:movies_app/globals/localizations/languages/tr.dart';

class LocalizationUtil extends Translations {
  // fallbackLocale saves the day when the locale gets in trouble
  static const fallbackLocale = Locale('tr', 'TR');

  // Default locale
  static Locale defaultLocale() {
    return const Locale('tr', 'TR');
  }

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
        'tr_TR': tr,
        'en_US': en,
      };

  // Supported languages
  // Needs to be same order with locales
  static final langs = ['Türkçe', "İngilizce"];

  // Supported locales
  // Needs to be same order with languages
  static final locales = [
    const Locale('tr', 'TR'),
  ];

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
  }

  // Finds language in `languages` list and returns it as Locale
  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }
}
