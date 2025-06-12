import 'package:worktracker/features/auth/domain/entities/user_entity.dart';
import 'package:worktracker/features/auth/domain/repositories/auth_repository.dart';

class SignInWithGoogle {
  final AuthRepository authRepository;
  SignInWithGoogle({required this.authRepository});

  Future<UserEntity> call() => authRepository.signInWithGoogle();
}
