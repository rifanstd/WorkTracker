import 'package:worktracker/core/services/auth_service.dart';
import 'package:worktracker/core/services/remote_config_service.dart';
import 'package:worktracker/core/utils/constants/remote_config.dart';
import 'package:worktracker/features/splash/domain/repositories/splash_repository.dart';
import 'package:worktracker/shared/entities/user_entity.dart';

class SplashRepositoryImpl implements SplashRepository {
  final AuthService authService;
  final RemoteConfigService remoteConfigService;

  SplashRepositoryImpl({
    required this.authService,
    required this.remoteConfigService,
  });

  @override
  Future<UserEntity?> getSignedInUser() async {
    final user = await authService.getSignedInUser();
    if (user == null) {
      return null;
    }

    return UserEntity(
      uid: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
      photoUrl: user.photoURL ?? '',
    );
  }

  @override
  String getAppLatestVersion() {
    final latestVersion = remoteConfigService.getString(AppRemoteConfigConstants.appVersion);
    return latestVersion;
  }

  @override
  String getAndroidPlayStoreUrl() {
    final androidPlayStoreUrl = remoteConfigService.getString(AppRemoteConfigConstants.androidPlayStoreUrl);
    return androidPlayStoreUrl;
  }

  @override
  String getiOSAppStoreUrl() {
    final iOSAppStoreUrl = remoteConfigService.getString(AppRemoteConfigConstants.iOSAppStoreUrl);
    return iOSAppStoreUrl;
  }
}
