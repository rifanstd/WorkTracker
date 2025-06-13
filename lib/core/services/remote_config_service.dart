import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:worktracker/core/utils/logging/logger.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfigService({required FirebaseRemoteConfig remoteConfig})
      : _remoteConfig = remoteConfig;

  Future<void> init({Duration fetchInterval = const Duration(hours: 1)}) async {
    try {
      AppLogger.info('[REMOTE_CONFIG] Initializing');
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: fetchInterval,
      ));
      await _remoteConfig.fetchAndActivate();
      AppLogger.info('[REMOTE_CONFIG] Initialized & Activated');
    } catch (e, stack) {
      AppLogger.error('[REMOTE_CONFIG] Initialization failed', e, stack);
      rethrow;
    }
  }

  String getString(String key) {
    final value = _remoteConfig.getString(key);
    AppLogger.debug('[REMOTE_CONFIG] getString("$key") = $value');
    return value;
  }

  bool getBool(String key) {
    final value = _remoteConfig.getBool(key);
    AppLogger.debug('[REMOTE_CONFIG] getBool("$key") = $value');
    return value;
  }

  int getInt(String key) {
    final value = _remoteConfig.getInt(key);
    AppLogger.debug('[REMOTE_CONFIG] getInt("$key") = $value');
    return value;
  }

  double getDouble(String key) {
    final value = _remoteConfig.getDouble(key);
    AppLogger.debug('[REMOTE_CONFIG] getDouble("$key") = $value');
    return value;
  }
}
