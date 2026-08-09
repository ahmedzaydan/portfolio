import 'package:flutter/material.dart';

import '../../enums/language_enum.dart';
import '../../utils/constants_manager.dart';
import '../../utils/size_manager.dart';

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

  ColorScheme _createColorScheme() {
    const primaryBg = Color(0xFF080C14);
    const surface = Color(0xFF0F1724);
    const card = Color(0xFF1A2336);
    const cyan = Color(0xFF00D4F5);
    const purple = Color(0xFF6C63FF);
    const textPrimary = Color(0xFFE8EDF5);
    const textSecondary = Color(0xFF8B9BB4);
    const textMuted = Color(0xFF4A5568);

    return const ColorScheme(
      brightness: Brightness.dark,
      // Core surface & background
      surface: surface,
      onSurface: textPrimary,
      onSurfaceVariant: textSecondary,
      surfaceContainerLowest: primaryBg,
      surfaceContainerLow: surface,
      surfaceContainer: card,
      surfaceContainerHigh: card,
      surfaceContainerHighest: card,
      // Primary = Cyan accent
      primary: cyan,
      onPrimary: primaryBg,
      primaryContainer: cyan,
      onPrimaryContainer: primaryBg,
      // Secondary = Purple accent
      secondary: purple,
      onSecondary: textPrimary,
      secondaryContainer: purple,
      onSecondaryContainer: textPrimary,
      // Tertiary (re-use cyan variant)
      tertiary: cyan,
      onTertiary: primaryBg,
      tertiaryContainer: cyan,
      onTertiaryContainer: primaryBg,
      // Error – keep a visible red
      error: Color(0xFFCF6679),
      onError: primaryBg,
      errorContainer: Color(0xFF93000A),
      onErrorContainer: Color(0xFFFFDAD6),
      // Outline / divider
      outline: textMuted,
      outlineVariant: card,
      // Misc
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: textPrimary,
      onInverseSurface: primaryBg,
      inversePrimary: Color(0xFF006878),
    );
  }

  ThemeData _createTheme() {
    final colorScheme = _createColorScheme();

    return ThemeData(
      fontFamily: fontFamily,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      textTheme: _createTextTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.surfaceContainerLowest,
      cardColor: colorScheme.surfaceContainer,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 20.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: colorScheme.primary),
          foregroundColor: colorScheme.primary,
          padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 20.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
    );
  }

  TextTheme _createTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      // Display
      displayLarge: TextStyle(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.bold,
      ),
      // Headline
      headlineLarge: TextStyle(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
      // Title
      titleLarge: TextStyle(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w500,
      ),
      // Body
      bodyLarge: TextStyle(color: colorScheme.onSurface),
      bodyMedium: TextStyle(color: colorScheme.onSurfaceVariant),
      bodySmall: TextStyle(color: colorScheme.outline),
      // Label
      labelLarge: TextStyle(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        color: colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        color: colorScheme.outline,
        fontWeight: FontWeight.w500,
      ),
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
