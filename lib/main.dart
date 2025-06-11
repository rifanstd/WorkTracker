import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:worktracker/app.dart';
import 'package:worktracker/config/di/injection_container.dart';
import 'package:worktracker/firebase_options.dart';

void main() async {
  await setup();
  runApp(const WorkTrackerApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();
}
