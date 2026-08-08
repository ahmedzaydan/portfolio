import 'package:flutter/material.dart';

extension ColorExtension on Color {
  /// Returns the color as a hex string in Figma style (e.g., "#000000")
  String toHex() {
    final red = (r * 255.0).round().clamp(0, 255);
    final green = (g * 255.0).round().clamp(0, 255);
    final blue = (b * 255.0).round().clamp(0, 255);

    return '#${_toHexString(red)}${_toHexString(green)}${_toHexString(blue)}';
  }

  /// Converts an integer (0-255) to a 2-digit uppercase hex string
  String _toHexString(int value) {
    return value.toRadixString(16).padLeft(2, '0').toUpperCase();
  }

  /// Pass an opacity value either as a percentage (0-100) or a decimal (0.0-1.0)
  /// to get the color with the specified opacity.
  Color withCustomOpacity(double opacity) {
    // Ensure opacity is between 0.0 and 1.0, if not divide it by 100
    if (opacity > 1.0) {
      opacity = opacity / 100.0;
    }

    return withAlpha((opacity * 255).toInt());
  }
}
