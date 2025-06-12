import 'package:worktracker/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signInWithGoogle();
  Future<void> signOut();
  Future<UserEntity?> getSignedInUser();
}
