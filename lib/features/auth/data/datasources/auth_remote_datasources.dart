import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:worktracker/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDatasources {
  Future<UserModel?> getCurrentUser();
  Future<UserModel> signInWithGoogle();
  Future<void> signOut();
}

@LazySingleton(as: AuthRemoteDatasources)
class AuthRemoteDatasourcesImpl implements AuthRemoteDatasources {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDatasourcesImpl(this._auth, this._googleSignIn);
  @override
  Future<UserModel?> getCurrentUser() async {
    final user = _auth.currentUser;
    return user != null ? UserModel.fromFirebaseUser(user) : null;
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth?.idToken,
      accessToken: googleAuth?.accessToken,
    );

    final userCred = await _auth.signInWithCredential(credential);
    return UserModel.fromFirebaseUser(userCred.user!);
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
