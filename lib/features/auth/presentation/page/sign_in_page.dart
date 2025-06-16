import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:worktracker/core/routes/app_navigator.dart';
import 'package:worktracker/core/routes/routes_name.dart';
import 'package:worktracker/core/utils/constants/image.dart';
import 'package:worktracker/core/utils/constants/strings.dart';
import 'package:worktracker/core/utils/constants/vectors.dart';
import 'package:worktracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worktracker/features/auth/presentation/bloc/auth_event.dart';
import 'package:worktracker/features/auth/presentation/bloc/auth_state.dart';
import 'package:worktracker/shared/presentation/widgets/app_dialog_widget.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              AppNavigator.goTo(context, RoutesName.home);
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
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.sizeOf(context).height,
                minWidth: MediaQuery.sizeOf(context).width,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.appName,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Worktracker membantumu tetap fokus dan terorganisir. Yuk mulai hari ini dengan langkah yang tepat!',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 32),
                    buildGoogleSignInButton(
                      context: context,
                      onPressed: () => context.read<AuthBloc>().add(const AuthSignInWithGoogle()),
                      imagePath: AppImages.google,
                      title: 'Sign In with Google',
                    ),
                    const SizedBox(height: 8),
                    buildGoogleSignInButton(
                      context: context,
                      onPressed: () {
                        AppDialogWidget.showFeatureNotAvailable(context);
                      },
                      imagePath: AppImages.apple,
                      title: 'Sign In with Apple',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGoogleSignInButton({
    required BuildContext context,
    required void Function() onPressed,
    required String imagePath,
    required String title,
  }) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 24,
            ),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
      ),
    );
  }
}
