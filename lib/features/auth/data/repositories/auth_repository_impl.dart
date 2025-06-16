import 'package:worktracker/core/services/auth_service.dart';
import 'package:worktracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:worktracker/shared/domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;

  AuthRepositoryImpl({required this.authService});

  @override
  Future<UserEntity> signInWithGoogle() async {
    final userCredential = await authService.signInWithGoogle();
    final user = userCredential.user;

    if (user == null) {
      throw Exception('Google sign-in failed');
    }

    return UserEntity(
      uid: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
      photoUrl: user.photoURL ?? '',
    );
  }

  @override
  Future<void> signOut() async {
    await authService.signOut();
  }
}
