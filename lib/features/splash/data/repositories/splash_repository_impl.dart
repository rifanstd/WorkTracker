import 'package:worktracker/core/services/firebase_remote_config_service.dart';
import 'package:worktracker/core/utils/constants/remote_config.dart';
import 'package:worktracker/features/splash/domain/repositories/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  final FirebaseRemoteConfigService remoteConfigService;

  SplashRepositoryImpl({
    required this.remoteConfigService,
  });

  @override
  String getAppLatestVersion() {
    final latestVersion =
        remoteConfigService.getString(AppRemoteConfigConstants.appVersion);
    return latestVersion;
  }

  @override
  String getAndroidPlayStoreUrl() {
    final androidPlayStoreUrl = remoteConfigService
        .getString(AppRemoteConfigConstants.androidPlayStoreUrl);
    return androidPlayStoreUrl;
  }

  @override
  String getiOSAppStoreUrl() {
    final iOSAppStoreUrl =
        remoteConfigService.getString(AppRemoteConfigConstants.iOSAppStoreUrl);
    return iOSAppStoreUrl;
  }

  @override
  bool getMaintenanceStatus() {
    final isMaintenance =
        remoteConfigService.getBool(AppRemoteConfigConstants.isMaintenanceMode);
    return isMaintenance;
  }
}
