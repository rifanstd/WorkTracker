import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:worktracker/core/routes/app_navigator.dart';
import 'package:worktracker/core/routes/routes_name.dart';
import 'package:worktracker/core/utils/constants/vectors.dart';
import 'package:worktracker/shared/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:worktracker/shared/blocs/connectivity_bloc/connectivity_state.dart';

class ConnectivityListenerWidget extends StatelessWidget {
  final Widget child;
  const ConnectivityListenerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listener: (context, state) {
        if (state is ConnectivityDisconnected) {
          showNoConnectionDialog(context);
        } else if (state is ConnectivityConnected) {
          final isSplashPage =
              GoRouter.of(AppNavigator.navigationKey.currentContext!).namedLocation(RoutesName.splash) ==
                  RoutesName.splash;

          if (isSplashPage) {
            Navigator.of(AppNavigator.navigationKey.currentContext!).popUntil((route) => route.isFirst);
          } else {
            AppNavigator.pop(context);
          }
        }
      },
      child: child,
    );
  }

  void showNoConnectionDialog(BuildContext context) {
    showDialog<void>(
      barrierDismissible: false,
      context: AppNavigator.navigationKey.currentContext!,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.bottomCenter,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AppVectors.noInternet, width: 160),
                  Text(
                    'Oops! Koneksi Terputus',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Kami tidak dapat mendeteksi koneksi internet. '
                    'Pastikan kamu terhubung ke jaringan agar aplikasi dapat berjalan dengan baik.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
