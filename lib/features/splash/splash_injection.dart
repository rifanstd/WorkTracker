import 'package:worktracker/core/di/injection_container.dart';
import 'package:worktracker/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:worktracker/features/splash/domain/repositories/splash_repository.dart';
import 'package:worktracker/features/splash/domain/usecases/get_android_play_store_url.dart';
import 'package:worktracker/features/splash/domain/usecases/get_app_latest_version.dart';
import 'package:worktracker/features/splash/domain/usecases/get_ios_app_store_url.dart';
import 'package:worktracker/features/splash/domain/usecases/get_signed_user.dart';
import 'package:worktracker/features/splash/presentation/bloc/splash_bloc.dart';

Future<void> initSplashDependencies() async {
  // Repository
  sl.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(
      authService: sl(),
      remoteConfigService: sl(),
    ),
  );

  // Bloc
  sl.registerFactory<SplashBloc>(
    () => SplashBloc(
      getAppLatestVersion: sl(),
      getSignedUser: sl(),
      getAndroidPlayStoreUrl: sl(),
      getiOSAppStoreUrl: sl(),
    ),
  );

  // Usecases
  sl.registerLazySingleton(() => GetAppLatestVersion(splashRepository: sl<SplashRepository>()));
  sl.registerLazySingleton(() => GetAndroidPlayStoreUrl(splashRepository: sl<SplashRepository>()));
  sl.registerLazySingleton(() => GetiOSAppStoreUrl(splashRepository: sl<SplashRepository>()));
  sl.registerLazySingleton(() => GetSignedUser(splashRepository: sl<SplashRepository>()));
}
