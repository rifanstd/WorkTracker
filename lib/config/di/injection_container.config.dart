// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:worktracker/config/di/injectable_modules.dart' as _i124;
import 'package:worktracker/features/auth/data/datasources/auth_remote_datasources.dart'
    as _i792;
import 'package:worktracker/features/auth/data/repositories/auth_repository_impl.dart'
    as _i40;
import 'package:worktracker/features/auth/domain/repositories/auth_repository.dart'
    as _i923;
import 'package:worktracker/features/auth/domain/usecases/get_current_user.dart'
    as _i100;
import 'package:worktracker/features/auth/domain/usecases/sign_in_with_google.dart'
    as _i261;
import 'package:worktracker/features/auth/domain/usecases/sign_out.dart'
    as _i988;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firebaseInjectableModule = _$FirebaseInjectableModule();
    gh.lazySingleton<_i59.FirebaseAuth>(
        () => firebaseInjectableModule.firebaseAuth);
    gh.lazySingleton<_i116.GoogleSignIn>(
        () => firebaseInjectableModule.googleSignIn);
    gh.lazySingleton<_i792.AuthRemoteDatasources>(
        () => _i792.AuthRemoteDatasourcesImpl(
              gh<_i59.FirebaseAuth>(),
              gh<_i116.GoogleSignIn>(),
            ));
    gh.lazySingleton<_i923.AuthRepository>(
        () => _i40.AuthRepositoryImpl(gh<_i792.AuthRemoteDatasources>()));
    gh.lazySingleton<_i100.GetCurrentUser>(
        () => _i100.GetCurrentUser(gh<_i923.AuthRepository>()));
    gh.lazySingleton<_i261.SignInWithGoogle>(
        () => _i261.SignInWithGoogle(gh<_i923.AuthRepository>()));
    gh.lazySingleton<_i988.SignOut>(
        () => _i988.SignOut(gh<_i923.AuthRepository>()));
    return this;
  }
}

class _$FirebaseInjectableModule extends _i124.FirebaseInjectableModule {}
