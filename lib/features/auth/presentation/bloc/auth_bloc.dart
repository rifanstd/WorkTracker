import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worktracker/core/utils/logger.dart';
import 'package:worktracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:worktracker/features/auth/presentation/bloc/auth_event.dart';
import 'package:worktracker/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthChecRequested);
    on<AuthSignInWithGoogle>(_onAuthSignInWithGoogle);
  }

  Future<void> _onAuthChecRequested(AuthCheckRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      AppLogger.info('[AUTH BLOC] AuthCheckRequested');
      final user = await authRepository.getSignedInUser();
      if (user != null) {
        AppLogger.info('[AUTH BLOC] User is authenticated: ${user.email}');
        emit(Authenticated(user));
      } else {
        AppLogger.info('[AUTH BLOC] No user is signed in');
        emit(const Unauthenticated());
      }
    } on Exception catch (e, stack) {
      AppLogger.error('[AUTH BLOC] AuthCheck failed', e, stack);
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onAuthSignInWithGoogle(AuthSignInWithGoogle event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      AppLogger.info('[AUTH BLOC] SignInWithGoogle requested');
      final user = await authRepository.signInWithGoogle();
      AppLogger.info('[AUTH BLOC] User signed in: ${user.email}');
      emit(Authenticated(user));
    } on Exception catch (e, stack) {
      AppLogger.error('[AUTH BLOC] SignInWithGoogle failed', e, stack);
      emit(AuthError(e.toString()));
    }
  }
}
