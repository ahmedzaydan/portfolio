import 'package:flutter/material.dart';

import '../enums/language_enum.dart';

abstract final class ConstantsManager {
  static const String iBMPlexSans = "IBMPlexSans";
  static const String iBMPlexSansArabic = "IBMPlexSansArabic";
  static const LanguageEnum fallbackLanguage = LanguageEnum.english;
  static const ThemeMode fallbackThemeMode = ThemeMode.light;
}
