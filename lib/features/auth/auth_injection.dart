import 'package:worktracker/core/di/injection_container.dart';
import 'package:worktracker/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:worktracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:worktracker/features/auth/domain/usecases/get_signed_user.dart';
import 'package:worktracker/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:worktracker/features/auth/domain/usecases/sign_out.dart';
import 'package:worktracker/features/auth/presentation/bloc/auth_bloc.dart';

Future<void> initAuthDependencies() async {
  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(authService: sl()));

  // Bloc
  sl.registerFactory<AuthBloc>(() => AuthBloc(authRepository: sl<AuthRepository>()));

  // Usecases
  sl.registerLazySingleton(() => GetSignedUser(authRepository: sl<AuthRepository>()));
  sl.registerLazySingleton(() => SignInWithGoogle(authRepository: sl<AuthRepository>()));
  sl.registerLazySingleton(() => SignOut(authRepository: sl<AuthRepository>()));
}
