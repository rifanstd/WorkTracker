import 'package:worktracker/features/splash/domain/repositories/splash_repository.dart';

class GetiOSAppStoreUrl {
  final SplashRepository splashRepository;

  GetiOSAppStoreUrl({required this.splashRepository});

  String call() => splashRepository.getiOSAppStoreUrl();
}
