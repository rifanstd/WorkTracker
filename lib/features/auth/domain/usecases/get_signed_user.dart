import 'package:worktracker/features/auth/domain/entities/user_entity.dart';
import 'package:worktracker/features/auth/domain/repositories/auth_repository.dart';

class GetSignedUser {
  final AuthRepository authRepository;
  GetSignedUser({required this.authRepository});

  Future<UserEntity?> call() async => authRepository.getSignedInUser();
}
