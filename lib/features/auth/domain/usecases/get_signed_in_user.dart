import 'package:worktracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:worktracker/shared/domain/entities/user_entity.dart';

class GetSignedInUser {
  final AuthRepository authRepository;
  GetSignedInUser({required this.authRepository});

  Future<UserEntity?> call() async => authRepository.getSignedInUser();
}
