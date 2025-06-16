import 'package:worktracker/shared/domain/entities/user_entity.dart';

abstract class SplashRepository {
  String getAppLatestVersion();
  String getAndroidPlayStoreUrl();
  String getiOSAppStoreUrl();
  bool getMaintenanceStatus();
  Future<UserEntity?> getSignedInUser();
}
