import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:worktracker/core/utils/logger.dart';

class AuthService {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthService({required this.firebaseAuth, required this.googleSignIn});

  User? get currentUser => firebaseAuth.currentUser;

  Stream<User?> authStateChanges() => firebaseAuth.authStateChanges();

  Future<UserCredential> signInWithGoogle() async {
    try {
      AppLogger.info('[AUTH SERVICE] Starting Google Sign-In');

      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        AppLogger.warn('[AUTH SERVICE] Google Sign-In cancelled by user');
        throw Exception('Google Sign-In cancelled');
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await firebaseAuth.signInWithCredential(credential);

      AppLogger.info(
        '[AUTH SERVICE] Google Sign-In successful: UID => ${userCredential.user?.uid}',
      );

      return userCredential;
    } catch (e, stack) {
      AppLogger.error('[AUTH SERVICE] Google Sign-In failed', e, stack);
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await googleSignIn.signOut();
      await firebaseAuth.signOut();
      AppLogger.info('[AUTH SERVICE] User signed out');
    } catch (e, stack) {
      AppLogger.error('[AUTH SERVICE] Sign-Out failed', e, stack);
      rethrow;
    }
  }

  Future<User?> getSignedInUser() async {
    try {
      if (currentUser != null) {
        AppLogger.info('[AUTH SERVICE] Signed-in user: UID => ${currentUser?.uid}');
      } else {
        AppLogger.warn('[AUTH SERVICE] No user currently signed in');
      }
      return currentUser;
    } catch (e, stack) {
      AppLogger.error('[AUTH SERVICE] Failed to get signed-in user', e, stack);
      rethrow;
    }
  }
}
