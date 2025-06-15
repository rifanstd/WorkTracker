import 'package:worktracker/shared/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signInWithGoogle();
  Future<void> signOut();
}
