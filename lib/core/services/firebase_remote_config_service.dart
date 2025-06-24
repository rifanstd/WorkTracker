import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:worktracker/core/utils/logging/logger.dart';

class FirebaseRemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  FirebaseRemoteConfigService({required FirebaseRemoteConfig remoteConfig})
      : _remoteConfig = remoteConfig;

  Future<void> init({Duration fetchInterval = Duration.zero}) async {
    try {
      AppLogger.info('[FIREBASE REMOTE CONFIG] Initializing');
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: fetchInterval,
        ),
      );
      await _remoteConfig.fetchAndActivate();
      AppLogger.info('[FIREBASE REMOTE CONFIG] Initialized & Activated');
    } catch (e, stack) {
      AppLogger.error(
          '[FIREBASE REMOTE CONFIG] Initialization failed', e, stack);
      rethrow;
    }
  }

  String getString(String key) {
    final value = _remoteConfig.getString(key);
    AppLogger.debug('[FIREBASE REMOTE CONFIG] getString("$key") = $value');
    return value;
  }

  bool getBool(String key) {
    final value = _remoteConfig.getBool(key);
    AppLogger.debug('[FIREBASE REMOTE CONFIG] getBool("$key") = $value');
    return value;
  }

  int getInt(String key) {
    final value = _remoteConfig.getInt(key);
    AppLogger.debug('[FIREBASE REMOTE CONFIG] getInt("$key") = $value');
    return value;
  }

  double getDouble(String key) {
    final value = _remoteConfig.getDouble(key);
    AppLogger.debug('[FIREBASE REMOTE CONFIG] getDouble("$key") = $value');
    return value;
  }
}
