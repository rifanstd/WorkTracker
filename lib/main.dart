import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worktracker/app.dart';
import 'package:worktracker/core/utils/logger.dart';
import 'package:worktracker/firebase_options.dart';

void configureStatusBar() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white.withValues(alpha: 0.003),
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /* TODO Initialize Crashlytics */
  /* TODO Initialize Dependencies */
  /* TODO Initialize Logger */

  configureStatusBar();

  if (kDebugMode) {
    Bloc.observer = AppBlocObserver();
  }

  runApp(const WorkTrackerApp());
}

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(bloc) {
    super.onCreate(bloc);
    AppLogger.info('onCreate -- bloc: ${bloc.runtimeType}');
  }

  @override
  void onEvent(bloc, Object? event) {
    super.onEvent(bloc, event);
    AppLogger.info('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onChange(bloc, change) {
    super.onChange(bloc, change);
    AppLogger.info('onChange -- bloc: ${bloc.runtimeType}, change: $change');
  }

  @override
  void onTransition(bloc, transition) {
    super.onTransition(bloc, transition);
    AppLogger.info(
        'onTransition -- bloc: ${bloc.runtimeType}, transition: $transition');
  }

  @override
  void onError(bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    AppLogger.error('onError -- bloc: ${bloc.runtimeType}, error: $error');
  }

  @override
  void onClose(bloc) {
    super.onClose(bloc);
    AppLogger.info('onClose -- bloc: ${bloc.runtimeType}');
  }
}
