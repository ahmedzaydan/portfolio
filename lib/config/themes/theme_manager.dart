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

  // Backgrounds
  static const _primaryBg = Color(0xFF080C14);
  static const _surface = Color(0xFF0F1724);
  static const _card = Color(0xFF1A2336);

  // Accents
  static const _cyan = Color(0xFF00D4F5);
  static const _purple = Color(0xFF6C63FF);

  // Text
  static const _textPrimary = Color(0xFFE8EDF5);
  static const _textSecondary = Color(0xFF8B9BB4);
  static const _textMuted = Color(0xFF4A5568);

  ThemeData _createTheme() {
    const colorScheme = ColorScheme(
      brightness: Brightness.dark,
      // Core surface & background
      surface: _surface,
      onSurface: _textPrimary,
      surfaceContainerLowest: _primaryBg,
      surfaceContainerLow: _surface,
      surfaceContainer: _card,
      surfaceContainerHigh: _card,
      surfaceContainerHighest: _card,
      // Primary = Cyan accent
      primary: _cyan,
      onPrimary: _primaryBg,
      primaryContainer: _cyan,
      onPrimaryContainer: _primaryBg,
      // Secondary = Purple accent
      secondary: _purple,
      onSecondary: _textPrimary,
      secondaryContainer: _purple,
      onSecondaryContainer: _textPrimary,
      // Tertiary (re-use cyan variant)
      tertiary: _cyan,
      onTertiary: _primaryBg,
      tertiaryContainer: _cyan,
      onTertiaryContainer: _primaryBg,
      // Error – keep a visible red
      error: Color(0xFFCF6679),
      onError: _primaryBg,
      errorContainer: Color(0xFF93000A),
      onErrorContainer: Color(0xFFFFDAD6),
      // Outline / divider
      outline: _textMuted,
      outlineVariant: _card,
      // Misc
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: _textPrimary,
      onInverseSurface: _primaryBg,
      inversePrimary: Color(0xFF006878),
    );

    const textTheme = TextTheme(
      // Display
      displayLarge: TextStyle(color: _textPrimary, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(
        color: _textPrimary,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(color: _textPrimary, fontWeight: FontWeight.bold),
      // Headline
      headlineLarge: TextStyle(
        color: _textPrimary,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: _textPrimary,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        color: _textPrimary,
        fontWeight: FontWeight.w600,
      ),
      // Title
      titleLarge: TextStyle(color: _textPrimary, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(
        color: _textSecondary,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(color: _textSecondary, fontWeight: FontWeight.w500),
      // Body
      bodyLarge: TextStyle(color: _textPrimary),
      bodyMedium: TextStyle(color: _textSecondary),
      bodySmall: TextStyle(color: _textMuted),
      // Label
      labelLarge: TextStyle(color: _textPrimary, fontWeight: FontWeight.w500),
      labelMedium: TextStyle(
        color: _textSecondary,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(color: _textMuted, fontWeight: FontWeight.w500),
    );

    return ThemeData(
      fontFamily: fontFamily,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: _primaryBg,
      cardColor: _card,
    );
  }

  Curve get themeAnimationCurve => Curves.easeInOut;

  Duration get themeAnimationDuration => const Duration(milliseconds: 300);

  AnimationStyle get themeAnimationStyle => const AnimationStyle(
    curve: Curves.easeInOut,
    duration: Duration(milliseconds: 300),
    reverseCurve: Curves.easeInOut,
    reverseDuration: Duration(milliseconds: 300),
  );
}
