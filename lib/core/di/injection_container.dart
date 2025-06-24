import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:worktracker/core/services/firebase_auth_service.dart';
import 'package:worktracker/core/services/firebase_firestore_service.dart';
import 'package:worktracker/core/services/firebase_remote_config_service.dart';
import 'package:worktracker/core/services/firebase_storage_service.dart';
import 'package:worktracker/core/services/url_launcher_service.dart';
import 'package:worktracker/features/auth/auth_injection.dart';
import 'package:worktracker/features/splash/splash_injection.dart';
import 'package:worktracker/shared/presentation/blocs/connectivity_bloc/connectivity_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Connection Bloc
  sl.registerLazySingleton<ConnectivityBloc>(ConnectivityBloc.new);

  // Firebase core services
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  sl.registerLazySingleton<FirebaseRemoteConfig>(
      () => FirebaseRemoteConfig.instance);
  sl.registerLazySingleton<GoogleSignIn>(GoogleSignIn.new);

  // App Services
  sl.registerLazySingleton<FirebaseAuthService>(
      () => FirebaseAuthService(firebaseAuth: sl(), googleSignIn: sl()));
  sl.registerLazySingleton<FirebaseFirestoreService>(
      () => FirebaseFirestoreService(firestore: sl()));
  sl.registerLazySingleton<FirebaseStorageService>(
      () => FirebaseStorageService(storage: sl()));
  sl.registerLazySingleton<FirebaseRemoteConfigService>(
      () => FirebaseRemoteConfigService(remoteConfig: sl()));
  sl.registerLazySingleton<UrlLauncherService>(UrlLauncherService.new);

  // Features
  await SplashInjection.init();
  await AuthInjection.init();
}
