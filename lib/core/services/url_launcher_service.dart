import 'package:url_launcher/url_launcher.dart';
import 'package:worktracker/core/utils/logging/logger.dart';

class UrlLauncherService {
  Future<void> openUrl(String url) async {
    try {
      AppLogger.info('[URL_LAUNCHER] Launching: $url');
      final uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        AppLogger.error('[URL_LAUNCHER] Could not launch: $url');
        throw Exception('Could not launch $url');
      }
      AppLogger.info('[URL_LAUNCHER] Success, opening: $url');
    } catch (e, stack) {
      AppLogger.error('[URL_LAUNCHER] Error at $url', e, stack);
      rethrow;
    }
  }
}
