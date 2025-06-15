import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worktracker/core/di/injection_container.dart';
import 'package:worktracker/core/routes/app_navigator.dart';
import 'package:worktracker/core/routes/routes_name.dart';
import 'package:worktracker/core/utils/constants/strings.dart';
import 'package:worktracker/core/utils/constants/vectors.dart';
import 'package:worktracker/core/utils/logging/logger.dart';
import 'package:worktracker/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:worktracker/features/splash/presentation/bloc/splash_event.dart';
import 'package:worktracker/features/splash/presentation/bloc/splash_state.dart';
import 'package:worktracker/shared/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:worktracker/shared/blocs/connectivity_bloc/connectivity_state.dart';
import 'package:worktracker/shared/widgets/app_dialog_widget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (context) => sl<SplashBloc>(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<ConnectivityBloc, ConnectivityState>(
            listener: (context, state) {
              if (state is ConnectivityConnected) {
                // context.read<SplashBloc>().add(const CheckSignedInUser());
                context.read<SplashBloc>().add(const CheckAppVersion());
              }
            },
          ),
          BlocListener<SplashBloc, SplashState>(
            listener: (context, state) {
              if (state is AppVersionUpToDate) {
                /* TODO: Maybe we have to check maintenance or not first */
                context.read<SplashBloc>().add(const CheckSignedInUser());
              } else if (state is AppVersionOutdated) {
                AppDialogWidget.show(
                  isDismissible: false,
                  context: AppNavigator.navigationKey.currentContext!,
                  vectorImagePath: AppVectors.update,
                  title: 'Versi Terbaru Tersedia',
                  message: 'Silahkan perbarui aplikasi ke versi terbaru untuk melanjutkan.',
                  confirmText: 'Perbarui Sekarang',
                  onConfirm: () async {
                    /* TODO: Go to playstore / appstore */
                    AppLogger.info('[SPLASH PAGE | LISTENER] Go to playstore / appstore');
                  },
                );
              } else if (state is UserSignedIn) {
              } else if (state is UserNotSignedIn) {
                AppNavigator.goTo(context, RoutesName.signIn);
              } else if (state is SplashError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.message}')),
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
      ),
    );
  }
}
