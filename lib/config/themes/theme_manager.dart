import 'package:flutter/material.dart';

import '../../enums/language_enum.dart';
import '../../utils/constants_manager.dart';
import '../../utils/size_manager.dart';
import 'color_manager.dart';
import 'text_styles_theme_extension.dart';

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

  ThemeData _createTheme() {
    final colorScheme = ColorManager.createColorScheme();
    final textStyles = TextStylesThemeExtension(
      color: colorScheme.onSurface,
      fontFamily: fontFamily,
    );

    return ThemeData(
      fontFamily: fontFamily,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surfaceContainerLowest,
      cardColor: colorScheme.surfaceContainer,
      extensions: [textStyles],
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(0, 56.h),
          maximumSize: Size.fromHeight(56.h),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          textStyle: textStyles.label.medium,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: Size(0, 56.h),
          maximumSize: Size.fromHeight(56.h),
          side: BorderSide(color: colorScheme.primary),
          foregroundColor: colorScheme.primary,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          textStyle: textStyles.label.medium,
        ),
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
