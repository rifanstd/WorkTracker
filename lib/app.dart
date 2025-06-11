import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worktracker/config/di/injection_container.dart';
import 'package:worktracker/config/routes/app_router.dart';
import 'package:worktracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worktracker/features/auth/presentation/bloc/auth_event.dart';

class WorkTrackerApp extends StatelessWidget {
  const WorkTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthBloc>()..add(CheckAuthStatus()),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'WorkTracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
