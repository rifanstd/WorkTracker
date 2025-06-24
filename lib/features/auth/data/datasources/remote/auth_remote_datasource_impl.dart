import 'package:worktracker/core/services/firebase_auth_service.dart';
import 'package:worktracker/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:worktracker/shared/domain/entities/user_entity.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuthService firebaseAuthService;

  AuthRemoteDatasourceImpl({required this.firebaseAuthService});
  @override
  Future<UserEntity?> getSignedInUser() async {
    final user = await firebaseAuthService.getSignedInUser();
    if (user == null) {
      return null;
    }

    return UserEntity(
      uid: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
      photoUrl: user.photoURL ?? '',
    );
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    final userCredential = await firebaseAuthService.signInWithGoogle();
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
    return firebaseAuthService.signOut();
  }
}
