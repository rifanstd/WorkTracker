import 'package:worktracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:worktracker/shared/domain/entities/user_entity.dart';

class SignInWithGoogle {
  final AuthRepository authRepository;
  SignInWithGoogle({required this.authRepository});

  Future<UserEntity> call() => authRepository.signInWithGoogle();
}
