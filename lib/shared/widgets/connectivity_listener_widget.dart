import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:worktracker/core/routes/app_navigator.dart';
import 'package:worktracker/core/routes/routes_name.dart';
import 'package:worktracker/core/utils/constants/vectors.dart';
import 'package:worktracker/shared/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:worktracker/shared/blocs/connectivity_bloc/connectivity_state.dart';
import 'package:worktracker/shared/widgets/app_dialog_widget.dart';

class ConnectivityListenerWidget extends StatelessWidget {
  final Widget child;
  const ConnectivityListenerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listener: (context, state) {
        if (state is ConnectivityDisconnected) {
          AppDialogWidget.show(
            isDismissible: false,
            context: AppNavigator.navigationKey.currentContext!,
            vectorImagePath: AppVectors.noInternet,
            title: 'Oops! Koneksi Terputus',
            message:
                'Kami tidak dapat mendeteksi koneksi internet. Pastikan kamu terhubung ke jaringan agar aplikasi dapat berjalan dengan baik.',
          );
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
}
