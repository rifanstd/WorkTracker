import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:worktracker/config/routes/route_names.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Future<void> _signIn(BuildContext context) async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    if (!context.mounted) {
      return;
    }

    context.go(RouteNames.home);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: ElevatedButton.icon(
            onPressed: () => _signIn(context),
            icon: const Icon(Icons.login),
            label: const Text('Sign in with Google'),
          ),
        ),
      );
}
