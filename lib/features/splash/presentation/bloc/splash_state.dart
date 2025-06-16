import 'package:equatable/equatable.dart';
import 'package:worktracker/shared/domain/entities/user_entity.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class AppVersionUpToDate extends SplashState {
  final String version;

  const AppVersionUpToDate({required this.version});

  @override
  List<Object?> get props => [version];
}

class AppVersionOutdated extends SplashState {
  final String version;
  final String androidPlayStoreUrl;
  final String iOSAppStoreUrl;

  const AppVersionOutdated(
      {required this.version,
      required this.androidPlayStoreUrl,
      required this.iOSAppStoreUrl});

  @override
  List<Object?> get props => [version];
}

class AppMaintenance extends SplashState {
  const AppMaintenance();

  @override
  List<Object?> get props => [];
}

class UserSignedIn extends SplashState {
  final UserEntity user;

  const UserSignedIn({required this.user});

  @override
  List<Object?> get props => [user];
}

class UserNotSignedIn extends SplashState {
  const UserNotSignedIn();

  @override
  List<Object?> get props => [];
}

class SplashError extends SplashState {
  final String message;

  const SplashError(this.message);

  @override
  List<Object?> get props => [message];
}
