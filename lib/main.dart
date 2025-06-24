import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:worktracker/app.dart';
import 'package:worktracker/core/di/injection_container.dart' as sl;
import 'package:worktracker/core/error/global_error_handler.dart';
import 'package:worktracker/core/services/firebase_remote_config_service.dart';
import 'package:worktracker/firebase_options.dart';

void configureStatusBar() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white.withOpacity(0.003),
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );
}

void main() {
  BindingBase.debugZoneErrorsAreFatal = true;

  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await sl.initDependencies();

      GlobalErrorHandler.initialize();

      await sl.sl<FirebaseRemoteConfigService>().init();

      configureStatusBar();
      runApp(const WorkTrackerApp());
    },
    GlobalErrorHandler.handleUncaught,
  );
}
