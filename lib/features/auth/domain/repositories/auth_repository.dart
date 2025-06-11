import 'package:worktracker/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> getCurrentUser();
  Future<UserEntity> signInWithGoogle();
  Future<void> signOut();
}
