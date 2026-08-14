enum DeviceTypeEnum {
  mobile(0),
  tablet(600),
  desktop(1000);

  static DeviceTypeEnum fromWidth(double width) {
    if (width < DeviceTypeEnum.tablet.breakpoint) {
      return DeviceTypeEnum.mobile;
    }

    if (width < DeviceTypeEnum.desktop.breakpoint) {
      return DeviceTypeEnum.tablet;
    }

    return DeviceTypeEnum.desktop;
  }

  bool get isMobile => this == DeviceTypeEnum.mobile;
  bool get isTablet => this == DeviceTypeEnum.tablet;
  bool get isDesktop => this == DeviceTypeEnum.desktop;

  final double breakpoint;
  const DeviceTypeEnum(this.breakpoint);
}
