import 'dart:math';

import 'package:flutter/material.dart';

import 'enums/device_type_enum.dart';

final class SizeManager {
  static SizeManager? _instance;

  SizeManager._() {
    _deviceSize = Size.zero;
    _initEmptySizeCache();
    splitScreenMode = true;
    deviceType = DeviceTypeEnum.mobile;
    isPortrait = true;
    insetBottomPadding = 0;
  }

  static SizeManager get instance => _instance ??= SizeManager._();

  late bool splitScreenMode;
  late DeviceTypeEnum deviceType;
  late bool isPortrait;
  late double insetBottomPadding;

  // ========== Size Properties ==========
  final _designSize = const Size(393, 852);

  late Size _deviceSize;
  Size get deviceSize => _deviceSize;

  late double _devicePixelRatio;
  double get devicePixelRatio => _devicePixelRatio;

  // ========== Scale Factors ==========
  late double _widthScaleFactor;
  late double _heightScaleFactor;

  final String _w = 'w';
  final String _h = 'h';
  final String _r = 'r';
  final String _sw = 'sw';
  final String _sh = 'sh';
  late Map<String, Map<num, double?>> _sizeCache;

  void updateInfo(BuildContext context, {bool splitScreenMode = true}) {
    this.splitScreenMode = splitScreenMode;
    _devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    insetBottomPadding = MediaQuery.viewInsetsOf(context).bottom;
    isPortrait = MediaQuery.orientationOf(context) == Orientation.portrait;

    final newSize = MediaQuery.sizeOf(context);
    if (newSize == _deviceSize) {
      return;
    }

    _deviceSize = newSize;
    _widthScaleFactor = _computeWidthScaleFactor();
    _heightScaleFactor = _computeHeightScaleFactor();
    deviceType = DeviceTypeEnum.fromWidth(_deviceSize.width);
    _initEmptySizeCache();
  }

  void _initEmptySizeCache() {
    _sizeCache = {_w: {}, _h: {}, _r: {}, _sw: {}, _sh: {}};
  }

  double _computeWidthScaleFactor() => _deviceSize.width / _designSize.width;

  double _computeHeightScaleFactor() {
    if (splitScreenMode) {
      return max(_deviceSize.height, 700) / _designSize.height;
    }
    return _deviceSize.height / _designSize.height;
  }

  /// Generic method for cached value computation.
  double _getCachedValue({
    required String key,
    required num value,
    required double Function(num value) computeFunction,
  }) {
    final cachedValue = _sizeCache[key]![value];
    if (cachedValue != null) return cachedValue;

    return _sizeCache[key]![value] = computeFunction(value).ceilToDouble();
  }

  /// Returns scaled width based on design size.
  double getWidth(num width) => _getCachedValue(
    key: _w,
    value: width,
    computeFunction: (value) => (value * _widthScaleFactor),
  );

  /// Returns scaled height based on design size.
  double getHeight(num height) => _getCachedValue(
    key: _h,
    value: height,
    computeFunction: (value) => (value * _heightScaleFactor),
  );

  /// Returns a multiple of the screen width.
  double getScreenWidth(num multiple) => _getCachedValue(
    key: _sw,
    value: multiple,
    computeFunction: (value) => (_deviceSize.width * value),
  );

  /// Returns a multiple of the screen height.
  double getScreenHeight(num multiple) => _getCachedValue(
    key: _sh,
    value: multiple,
    computeFunction: (value) => (_deviceSize.height * value),
  );

  /// Returns scaled radius based on the smaller scale factor.
  double getRadius(num radius) => _getCachedValue(
    key: _r,
    value: radius,
    computeFunction: (value) {
      final scaleFactor = min(_widthScaleFactor, _heightScaleFactor);
      return (value * scaleFactor);
    },
  );

  /// Returns a value based on the current device type and orientation.
  T conditionalValue<T>({
    required T mobile,
    required T tablet,
    T? largeTablet,
    T? desktop,
  }) {
    final value = switch (deviceType) {
      DeviceTypeEnum.mobile => mobile,
      DeviceTypeEnum.tablet => isPortrait ? tablet : (largeTablet ?? tablet),
      DeviceTypeEnum.largeTablet =>
        isPortrait ? largeTablet ?? tablet : (desktop ?? largeTablet ?? tablet),
      DeviceTypeEnum.desktop => desktop ?? largeTablet ?? tablet,
    };

    if (T is double || T is double?) {
      return (value as double).ceilToDouble() as T;
    }

    return value;
  }
}

extension NumExtension on num {
  /// Scales the number as width using [ValueManager].
  double get w => SizeManager.instance.getWidth(this);

  /// Scales the number as height using [ValueManager].
  double get h => SizeManager.instance.getHeight(this);

  /// Scales the number as radius using [ValueManager].
  double get r => SizeManager.instance.getRadius(this);

  /// Returns a multiple of screen width using [ValueManager].
  double get sw => SizeManager.instance.getScreenWidth(this);

  /// Returns a multiple of screen height using [ValueManager].
  double get sh => SizeManager.instance.getScreenHeight(this);
}

extension NullableNumExtension on num? {
  /// Scales the nullable number as width using [ValueManager].
  double? get w => this == null ? null : SizeManager.instance.getWidth(this!);

  /// Scales the nullable number as height using [ValueManager].
  double? get h => this == null ? null : SizeManager.instance.getHeight(this!);

  /// Scales the nullable number as radius using [ValueManager].
  double? get r => this == null ? null : SizeManager.instance.getRadius(this!);

  /// Returns a multiple of screen width using [ValueManager].
  double? get sw =>
      this == null ? null : SizeManager.instance.getScreenWidth(this!);

  /// Returns a multiple of screen height using [ValueManager].
  double? get sh =>
      this == null ? null : SizeManager.instance.getScreenHeight(this!);
}
