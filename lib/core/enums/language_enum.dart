
import 'package:flutter/material.dart';

import '../utils/constants_manager.dart';

enum LanguageEnum {
  english(code: 'en', displayName: 'English', flag: '🇬🇧'),
  arabic(code: 'ar', displayName: 'العربية', flag: '🇪🇬');

  final String code, displayName, flag;

  const LanguageEnum({
    required this.code,
    required this.displayName,
    required this.flag,
  });

  static LanguageEnum fromCode(String code) {
    return LanguageEnum.values.firstWhere(
      (lang) => lang.code == code,
      orElse: () => ConstantsManager.fallbackLanguage,
    );
  }

  bool get isRTL => this == LanguageEnum.arabic;

  String get fontFamily {
    return switch (this) {
      LanguageEnum.english => ConstantsManager.iBMPlexSans,
      LanguageEnum.arabic => ConstantsManager.iBMPlexSansArabic,
    };
  }

  Locale get locale => Locale(code);

  bool get isEnglish => this == LanguageEnum.english;
  bool get isArabic => this == LanguageEnum.arabic;
}
