import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

class CheckSignedInUser extends SplashEvent {
  const CheckSignedInUser();

  @override
  List<Object?> get props => [];
}

class CheckAppVersion extends SplashEvent {
  const CheckAppVersion();

  @override
  List<Object?> get props => [];
}
