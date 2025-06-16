import 'package:worktracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:worktracker/shared/domain/entities/user_entity.dart';

class GetSignedUser {
  final AuthRepository authRepository;
  GetSignedUser({required this.authRepository});

  Future<UserEntity?> call() async => authRepository.getSignedUser();
}
