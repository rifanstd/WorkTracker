import 'package:injectable/injectable.dart';
import 'package:worktracker/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton()
class SignOut {
  final AuthRepository repository;

  SignOut(this.repository);

  Future<void> call() async {
    return repository.signOut();
  }
}
