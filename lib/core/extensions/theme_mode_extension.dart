import 'package:flutter/material.dart';

extension ThemeModeExtension on ThemeMode {
  bool get isDark => this == ThemeMode.dark;
  bool get isLight => this == ThemeMode.light;

  ThemeMode get toggle => isDark ? ThemeMode.light : ThemeMode.dark;
}
