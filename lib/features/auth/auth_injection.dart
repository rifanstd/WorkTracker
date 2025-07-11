import 'package:worktracker/core/di/injection_container.dart';
import 'package:worktracker/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:worktracker/features/auth/data/datasources/remote/auth_remote_datasource_impl.dart';
import 'package:worktracker/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:worktracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:worktracker/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:worktracker/features/auth/domain/usecases/sign_out.dart';
import 'package:worktracker/features/auth/presentation/bloc/auth_bloc.dart';

class AuthInjection {
  AuthInjection._();

  static Future<void> init() async {
    // Datasource
    sl.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(firebaseAuthService: sl()),
    );

    // Repository
    sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(remoteDatasource: sl()));

    // Usecases
    sl.registerLazySingleton(
        () => SignInWithGoogle(authRepository: sl<AuthRepository>()));
    sl.registerLazySingleton(
        () => SignOut(authRepository: sl<AuthRepository>()));

    // Bloc
    sl.registerFactory<AuthBloc>(
        () => AuthBloc(signInWithGoogle: sl(), signOut: sl()));
  }
}
