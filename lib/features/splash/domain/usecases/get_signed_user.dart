import 'package:worktracker/features/splash/domain/repositories/splash_repository.dart';
import 'package:worktracker/shared/entities/user_entity.dart';

class GetSignedUser {
  final SplashRepository splashRepository;
  GetSignedUser({required this.splashRepository});

  Future<UserEntity?> call() async => splashRepository.getSignedInUser();
}
