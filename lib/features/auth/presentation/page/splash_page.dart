import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worktracker/core/routes/app_navigator.dart';
import 'package:worktracker/core/routes/routes_name.dart';
import 'package:worktracker/core/utils/constants/strings.dart';
import 'package:worktracker/core/utils/constants/vectors.dart';
import 'package:worktracker/core/utils/helper/connectivity_helper.dart';
import 'package:worktracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worktracker/features/auth/presentation/bloc/auth_event.dart';
import 'package:worktracker/features/auth/presentation/bloc/auth_state.dart';
import 'package:worktracker/shared/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:worktracker/shared/blocs/connectivity_bloc/connectivity_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ConnectivityBloc, ConnectivityState>(
          listener: (context, state) {
            if (state is ConnectivityConnected) {
              context.read<AuthBloc>().add(const AuthCheckRequested());
            }
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
            } else if (state is Unauthenticated) {
              if (ConnectivityHelper.isConnected(context)) {
                AppNavigator.goTo(context, RoutesName.signIn);
              }
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Authentication error: ${state.message}')),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox.expand(
              child: Opacity(
                opacity: 0.05,
                child: SvgPicture.asset(
                  AppVectors.splash,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Text(
                AppStrings.appName,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Version ${AppStrings.appVersion}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
