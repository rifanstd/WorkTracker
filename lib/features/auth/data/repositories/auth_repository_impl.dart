import 'package:worktracker/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:worktracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:worktracker/shared/domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl({required this.remoteDatasource});

  @override
  Future<UserEntity> signInWithGoogle() async {
    return remoteDatasource.signInWithGoogle();
  }

  @override
  Future<void> signOut() async {
    await remoteDatasource.signOut();
  }

  @override
  Future<UserEntity?> getSignedInUser() async {
    return remoteDatasource.getSignedInUser();
  }
}
