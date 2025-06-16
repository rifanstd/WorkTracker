import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worktracker/core/routes/app_navigator.dart';
import 'package:worktracker/core/routes/routes_name.dart';
import 'package:worktracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worktracker/features/auth/presentation/bloc/auth_event.dart';
import 'package:worktracker/features/auth/presentation/bloc/auth_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Unauthenticated) {
              AppNavigator.goTo(context, RoutesName.signIn);
            }
          },
        ),
      ],
      child: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () => context.read<AuthBloc>().add(const AuthSignOut()),
            child: const Text('Sign Out'),
          ),
        ),
      ),
    );
  }
}
