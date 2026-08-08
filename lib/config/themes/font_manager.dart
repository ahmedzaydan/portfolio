import '../../core/enums/device_type_enum.dart';
import '../../core/size_manager.dart';

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
            ? sw / (desktopBP * 0.3)
            : sw / (desktopBP * 0.98);
      case DeviceTypeEnum.largeTablet:
        return SizeManager.instance.isPortrait
            ? sw / (desktopBP * 0.3)
            : sw / (desktopBP * 0.98);
      case DeviceTypeEnum.desktop:
        return SizeManager.instance.isPortrait
            ? sw / (desktopBP * 0.3)
            : sw / (desktopBP * 0.98);
    }
  }
}
