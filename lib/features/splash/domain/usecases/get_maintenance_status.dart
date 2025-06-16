import 'package:worktracker/features/splash/domain/repositories/splash_repository.dart';

class GetMaintenanceStatus {
  final SplashRepository splashRepository;

  GetMaintenanceStatus({required this.splashRepository});

  bool call() => splashRepository.getMaintenanceStatus();
}
