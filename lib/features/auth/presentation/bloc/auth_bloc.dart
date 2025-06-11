import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worktracker/features/auth/domain/usecases/get_current_user.dart';
import 'package:worktracker/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:worktracker/features/auth/domain/usecases/sign_out.dart';
import 'package:worktracker/features/auth/presentation/bloc/auth_event.dart';
import 'package:worktracker/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetCurrentUser getCurrentUser;
  final SignInWithGoogle signInWithGoogle;
  final SignOut signOut;

  AuthBloc({
    required this.getCurrentUser,
    required this.signInWithGoogle,
    required this.signOut,
  }) : super(AuthInitial()) {
    on<CheckAuthStatus>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await getCurrentUser();
        if (user != null) {
          emit(Authenticated(user));
        } else {
          Unauthenticated();
        }
      } on Exception catch (e) {
        emit(AuthError('Failed to check auth status: $e'));
      }
    });

    on<SignInWithGooglePressed>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await signInWithGoogle();
        emit(Authenticated(user));
      } on Exception catch (e) {
        emit(AuthError('Failed to sign in with Google: $e'));
      }
    });

    on<SignOutPressed>((event, emit) async {
      emit(AuthLoading());
      try {
        await signOut();
        emit(Unauthenticated());
      } on Exception catch (e) {
        emit(AuthError('Failed to sign out: $e'));
      }
    });
  }
}
