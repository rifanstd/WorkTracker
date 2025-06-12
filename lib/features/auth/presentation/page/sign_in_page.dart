import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worktracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worktracker/features/auth/presentation/bloc/auth_event.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.read<AuthBloc>().add(const AuthSignInWithGoogle()),
          child: const Text('Sign In with Google'),
        ),
      ),
    );
  }
}
