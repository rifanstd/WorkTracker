import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:worktracker/core/utils/logger.dart';

class AuthService {
  final FirebaseAuth firebaseAuth;

  AuthService({required this.firebaseAuth});

  User? get currentUser => firebaseAuth.currentUser;

  Stream<User?> authStateChanges() => firebaseAuth.authStateChanges();

  Future<UserCredential?> signInWithGoogle() async {
    try {
      AppLogger.info('[AUTH] Starting Google Sign-In');

      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        AppLogger.warn('[AUTH] Google Sign-In cancelled by user');
      }

      final googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await firebaseAuth.signInWithCredential(credential);

      AppLogger.info(
        '[AUTH] Google Sign-In successful: UID => ${userCredential.user?.uid}',
      );

      return userCredential;
    } catch (e, stack) {
      AppLogger.error('[AUTH] Google Sign-In failed', e, stack);
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await firebaseAuth.signOut();
      AppLogger.info('[AUTH] User signed out');
    } catch (e, stack) {
      AppLogger.error('[AUTH] Sign-Out failed', e, stack);
      rethrow;
    }
  }
}
