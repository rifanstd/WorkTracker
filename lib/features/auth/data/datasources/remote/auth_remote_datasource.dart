import 'package:worktracker/shared/domain/entities/user_entity.dart';

abstract class AuthRemoteDatasource {
  Future<UserEntity> signInWithGoogle();
  Future<void> signOut();
  Future<UserEntity?> getSignedInUser();
}
