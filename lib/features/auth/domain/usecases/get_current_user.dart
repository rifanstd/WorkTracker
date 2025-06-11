import 'package:injectable/injectable.dart';
import 'package:worktracker/features/auth/domain/entities/user_entity.dart';
import 'package:worktracker/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton()
class GetCurrentUser {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  Future<UserEntity?> call() async {
    return repository.getCurrentUser();
  }
}
