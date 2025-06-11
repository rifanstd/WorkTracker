import 'package:injectable/injectable.dart';
import 'package:worktracker/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:worktracker/features/auth/domain/entities/user_entity.dart';
import 'package:worktracker/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatasources remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<UserEntity?> getCurrentUser() => remote.getCurrentUser();

  @override
  Future<UserEntity> signInWithGoogle() => remote.signInWithGoogle();

  @override
  Future<void> signOut() => remote.signOut();
}
