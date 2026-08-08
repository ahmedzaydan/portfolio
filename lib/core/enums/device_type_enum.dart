enum DeviceTypeEnum {
  mobile(300),
  tablet(600),
  largeTablet(900),
  desktop(1200);

  static DeviceTypeEnum fromWidth(double width) {
    if (width < DeviceTypeEnum.tablet.breakpoint) {
      return DeviceTypeEnum.mobile;
    }

    if (width < DeviceTypeEnum.largeTablet.breakpoint) {
      return DeviceTypeEnum.tablet;
    }

    if (width < DeviceTypeEnum.desktop.breakpoint) {
      return DeviceTypeEnum.largeTablet;
    }

    return DeviceTypeEnum.desktop;
  }

  bool get isMobile => this == DeviceTypeEnum.mobile;
  bool get isTablet => this == DeviceTypeEnum.tablet;
  bool get isLargeTablet => this == DeviceTypeEnum.largeTablet;
  bool get isDesktop => this == DeviceTypeEnum.desktop;

  final double breakpoint;
  const DeviceTypeEnum(this.breakpoint);
}
