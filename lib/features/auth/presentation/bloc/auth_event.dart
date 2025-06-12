import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

class AuthSignInWithGoogle extends AuthEvent {
  const AuthSignInWithGoogle();
}

class AuthSignOut extends AuthEvent {
  const AuthSignOut();
}
