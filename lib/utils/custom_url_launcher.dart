import 'package:url_launcher/url_launcher.dart';

import 'custom_logger.dart';

abstract final class CustomUrlLauncher {
  static void launch(String url) async {
    try {
      final uri = Uri.parse(url);

      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        CustomLogger.error('Could not launch $url');
      }
    } catch (e) {
      CustomLogger.error('Error launching $url: $e');
    }
  }
}
