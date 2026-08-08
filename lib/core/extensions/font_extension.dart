import '../config/themes/font_manager.dart';

extension FontExtension on int {
  /// Gets the responsive font size based on the device's screen size.
  double get responsiveFont {
    return FontManager.getResponsiveFontSize(toDouble());
  }
}
