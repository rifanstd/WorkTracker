import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worktracker/core/di/injection_container.dart';
import 'package:worktracker/core/routes/app_router.dart';
import 'package:worktracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worktracker/features/auth/presentation/bloc/auth_event.dart';

class WorkTrackerApp extends StatelessWidget {
  const WorkTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()..add(const AuthCheckRequested())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        routerConfig: appRouter,
      ),
    );
  }
}
