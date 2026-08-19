import 'package:flutter/material.dart';

import '../../enums/device_type_enum.dart';
import '../../utils/size_manager.dart';

@immutable
class TextStylesThemeExtension
    extends ThemeExtension<TextStylesThemeExtension> {
  static const TextStyle _base = TextStyle();

  final TextStyleWeights display;
  final TextStyleWeights heading;
  final TextStyleWeights title;
  final TextStyleWeights body;
  final TextStyleWeights label;

  const TextStylesThemeExtension._private({
    required this.display,
    required this.heading,
    required this.title,
    required this.body,
    required this.label,
  });

  // MARK: create
  factory TextStylesThemeExtension({Color? color, String? fontFamily}) {
    final modified = _base.copyWith(color: color, fontFamily: fontFamily);

    return TextStylesThemeExtension._private(
      display: TextStyleWeights(
        base: modified.copyWith(fontSize: 20.responsiveFont),
      ),
      heading: TextStyleWeights(
        base: modified.copyWith(fontSize: 18.responsiveFont),
      ),
      title: TextStyleWeights(
        base: modified.copyWith(fontSize: 16.responsiveFont),
      ),
      body: TextStyleWeights(
        base: modified.copyWith(fontSize: 14.responsiveFont),
      ),
      label: TextStyleWeights(
        base: modified.copyWith(fontSize: 12.responsiveFont),
      ),
    );
  }

  // MARK: Copy with
  @override
  TextStylesThemeExtension copyWith() => this;

  @override
  TextStylesThemeExtension lerp(
    ThemeExtension<TextStylesThemeExtension>? other,
    double t,
  ) {
    if (other is! TextStylesThemeExtension) return this;

    return TextStylesThemeExtension._private(
      display: display.lerp(other.display, t),
      heading: heading.lerp(other.heading, t),
      title: title.lerp(other.title, t),
      body: body.lerp(other.body, t),
      label: label.lerp(other.label, t),
    );
  }
}

extension _IntExtension on int {
  /// Gets the responsive font size based on the device's screen size.
  double get responsiveFont {
    return FontManager.getResponsiveFontSize(toDouble());
  }
}

extension TextStyleExtension on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
}

extension NullableTextStyleExtension on TextStyle? {
  TextStyle? get bold => this?.copyWith(fontWeight: FontWeight.w700);
  TextStyle? get semiBold => this?.copyWith(fontWeight: FontWeight.w600);
  TextStyle? get medium => this?.copyWith(fontWeight: FontWeight.w500);
  TextStyle? get regular => this?.copyWith(fontWeight: FontWeight.w400);
}

class TextStyleWeights {
  final TextStyle _base;
  final TextStyle bold;
  final TextStyle semiBold;
  final TextStyle medium;
  final TextStyle regular;

  TextStyleWeights({required TextStyle base})
    : _base = base,
      bold = base.bold,
      semiBold = base.semiBold,
      medium = base.medium,
      regular = base.regular;

  TextStyleWeights lerp(TextStyleWeights other, double t) =>
      TextStyleWeights(base: TextStyle.lerp(_base, other._base, t) ?? _base);
}

class FontManager {
  FontManager._();

  static double getResponsiveFontSize(double fontSize) {
    final double scaleFactor = _getScaleFactor();
    final double responsiveSize = fontSize * scaleFactor;
    final double lowerLimit = fontSize * .9; // 90 % of font size
    final double upperLimit = fontSize * 1.5; // 150 % of font size
    final double result = responsiveSize.clamp(lowerLimit, upperLimit);
    return result;
  }

  static double _getScaleFactor() {
    final sw = SizeManager.instance.deviceSize.width;
    final tabletBP = DeviceTypeEnum.tablet.breakpoint;
    final desktopBP = DeviceTypeEnum.desktop.breakpoint;

    switch (SizeManager.instance.deviceType) {
      case DeviceTypeEnum.mobile:
        return sw / (tabletBP * 0.65);
      case DeviceTypeEnum.tablet:
        return SizeManager.instance.isPortrait
            ? sw / (desktopBP * 0.5)
            : sw / (desktopBP * 0.98);
      case DeviceTypeEnum.desktop:
        return sw / (desktopBP * 0.3);
    }
  }
}
