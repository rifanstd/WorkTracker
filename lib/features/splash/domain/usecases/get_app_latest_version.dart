import 'package:worktracker/features/splash/domain/repositories/splash_repository.dart';

class GetAppLatestVersion {
  final SplashRepository splashRepository;

  const GetAppLatestVersion({required this.splashRepository});

  String call() => splashRepository.getAppLatestVersion();
}
