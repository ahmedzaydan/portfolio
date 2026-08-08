import 'package:flutter/material.dart';

import '../../enums/language_enum.dart';
import '../../utils/constants_manager.dart';

class ThemeManager {
  ThemeManager._();

  static ThemeManager? _instance;

  static ThemeManager get instance => _instance ??= ThemeManager._();

  String? _fontFamily;

  ThemeData? _theme;

  String get fontFamily => _fontFamily ??= ConstantsManager.iBMPlexSans;

  ThemeData get theme => _theme ??= _createTheme();

  void setFontFamily(LanguageEnum language) =>
      _fontFamily = language.fontFamily;

  void onLangaugeChanged(LanguageEnum language) {
    setFontFamily(language);
    _theme = _createTheme();
  }

  ThemeData _createTheme() => ThemeData(
    fontFamily: fontFamily,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  );

  Curve get themeAnimationCurve => Curves.easeInOut;

  Duration get themeAnimationDuration => const Duration(milliseconds: 300);

  AnimationStyle get themeAnimationStyle => const AnimationStyle(
    curve: Curves.easeInOut,
    duration: Duration(milliseconds: 300),
    reverseCurve: Curves.easeInOut,
    reverseDuration: Duration(milliseconds: 300),
  );
}
