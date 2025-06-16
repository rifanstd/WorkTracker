import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worktracker/core/di/injection_container.dart';
import 'package:worktracker/core/routes/app_router.dart';
import 'package:worktracker/core/utils/constants/strings.dart';
import 'package:worktracker/core/utils/theme/theme.dart';
import 'package:worktracker/shared/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:worktracker/shared/widgets/connectivity_listener_widget.dart';

class WorkTrackerApp extends StatelessWidget {
  const WorkTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityBloc>(
          create: (_) => sl<ConnectivityBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        title: AppStrings.appName,
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        builder: (context, child) => ConnectivityListenerWidget(child: child!),
      ),
    );
  }
}
