import 'package:flutter/foundation.dart';

abstract class CustomLogger {
  static void _log(
    String message, {
    LogType level = LogType.debug,
    String? name,
  }) {
    if (kReleaseMode) return;
    debugPrint(
      '${_proessPrefix(level, name)}: $message${LoggerStyling.prefix}0${LoggerStyling.suffix}',
    );
  }

  static void debug(String message, {String? name}) =>
      _log(message, name: name);
  static void success(String message, {String? name}) =>
      _log(message, level: LogType.success, name: name);
  static void error(String message, {String? name}) =>
      _log(message, level: LogType.error, name: name);
  static void info(String message, {String? name}) =>
      _log(message, level: LogType.info, name: name);

  static String _proessPrefix(LogType type, String? name) {
    String prefix = '${type.color}[${type.name.toUpperCase()}]';
    if (name != null) {
      prefix += ' [$name]';
    }

    return prefix;
  }
}

enum LogType {
  debug(
    '${LoggerStyling.prefix}${LoggerStyling.brightYellow}${LoggerStyling.suffix}',
  ),
  success(
    '${LoggerStyling.prefix}${LoggerStyling.green}${LoggerStyling.suffix}',
  ),
  error('${LoggerStyling.prefix}${LoggerStyling.red}${LoggerStyling.suffix}'),
  info(
    '${LoggerStyling.prefix}${LoggerStyling.magenta}${LoggerStyling.suffix}',
  );

  final String color;

  const LogType(this.color);
}

abstract class LoggerStyling {
  static const String prefix = '\x1B[';
  static const String suffix = 'm';
  static const String separator = ';';

  static const String brightYellow = '93';
  static const String green = '32';
  static const String red = '31';
  static const String magenta = '35';
}

/*
=== ANSI COLOR AND FORMATTING REFERENCE ===

STANDARD COLORS (30-37):
- \x1B[30m - Black
- \x1B[31m - Red
- \x1B[32m - Green
- \x1B[33m - Yellow
- \x1B[34m - Blue
- \x1B[35m - Magenta
- \x1B[36m - Cyan
- \x1B[37m - White

BRIGHT/LIGHT COLORS (90-97):
- \x1B[90m - Bright Black (Gray)
- \x1B[91m - Bright Red
- \x1B[92m - Bright Green
- \x1B[93m - Bright Yellow
- \x1B[94m - Bright Blue
- \x1B[95m - Bright Magenta
- \x1B[96m - Bright Cyan
- \x1B[97m - Bright White

TEXT FORMATTING:
- \x1B[1m - Bold
- \x1B[3m - Italic
- \x1B[4m - Underline


COMBINED FORMATTING:
- \x1B[1;31m - Bold Red
- \x1B[4;94m - Underlined Bright Blue
- \x1B[1;3;32m - Bold Italic Green

RESET:
- \x1B[0m - Reset all formatting

USAGE EXAMPLE:
- debugPrint('\x1B[1;93m[WARNING]\x1B[0m: This is bold bright yellow text');
*/
