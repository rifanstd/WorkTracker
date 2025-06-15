import 'package:worktracker/features/splash/domain/repositories/splash_repository.dart';

class GetAndroidPlayStoreUrl {
  final SplashRepository splashRepository;

  GetAndroidPlayStoreUrl({required this.splashRepository});

  String call() => splashRepository.getAndroidPlayStoreUrl();
}
