import 'package:flutter/foundation.dart';
import 'package:worktracker/core/utils/logging/logger.dart';

class GlobalErrorHandler {
  static void initialize() {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      AppLogger.error(
        '[FLUTTER ERROR] ${details.exceptionAsString()}',
        details.exception,
        details.stack,
      );
    };

    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      AppLogger.error('[PLATFORM ERROR]', error, stack);
      return true;
    };
  }

  static void handleUncaught(Object error, StackTrace stack) {
    AppLogger.error('[UNCAUGHT ERROR]', error, stack);
  }
}
