import 'package:flutter/material.dart';

import '../../../enums/device_type_enum.dart';
import '../../../utils/size_manager.dart';

class ResponsiveLayoutBuilder extends StatelessWidget {
  final WidgetBuilder mobile;
  final WidgetBuilder tablet;
  final WidgetBuilder desktop;

  const ResponsiveLayoutBuilder({
    required this.mobile,
    required this.tablet,
    required this.desktop,
    super.key,
  });

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, _) => switch (SizeManager.instance.deviceType) {
      DeviceTypeEnum.mobile => mobile(context),
      DeviceTypeEnum.tablet => tablet(context),
      DeviceTypeEnum.desktop => desktop(context),
    },
  );
}
