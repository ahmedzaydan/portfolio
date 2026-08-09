import 'package:flutter/material.dart';

import '../../../enums/device_type_enum.dart';
import '../../../utils/size_manager.dart';

class ResponsiveLayoutBuilder extends StatelessWidget {
  final WidgetBuilder mobile;
  final WidgetBuilder desktop;

  const ResponsiveLayoutBuilder({
    required this.mobile,
    required this.desktop,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrints) {
        return switch (SizeManager.instance.deviceType) {
          DeviceTypeEnum.mobile => mobile(context),
          DeviceTypeEnum.tablet => mobile(context),
          DeviceTypeEnum.largeTablet => desktop(context),
          DeviceTypeEnum.desktop => desktop(context),
        };
      },
    );
  }
}
