import 'package:worktracker/features/auth/domain/repositories/auth_repository.dart';

class SignOut {
  final AuthRepository authRepository;
  SignOut({required this.authRepository});

  Future<void> call() => authRepository.signOut();
}
