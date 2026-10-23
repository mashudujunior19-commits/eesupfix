import 'package:bloc/bloc.dart';
import 'package:data/auth/data_source/abstract_auth_data_source.dart'
    show SocialProvider;
import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthBlocState> {
  final AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(UnAuthenticated()) {
    on<AppStarted>((event, emit) async {
      await for (final change in authRepository.authStateChanges) {
        final session = change.session;
        if (session == null) {
          emit(UnAuthenticated());
          continue;
        }
        // A leftover password-recovery session (the app was closed before
        // the user finished setting a new password) must never be treated
        // as a normal sign-in -- see AuthRepository.pendingPasswordReset.
        final pending = authRepository.pendingPasswordReset(session);
        if (pending != null) {
          emit(PasswordResetPending(email: pending.email, phone: pending.phone));
          continue;
        }
        // Google / Apple only sign in people who already registered.
        if (authRepository.isSocialSession(session) &&
            !await authRepository.allowSocialSession(session)) {
          emit(UnAuthenticated());
          continue;
        }
        emit(Authenticated(true));
      }
    });

    on<SignInPressed>((event, emit) async {
      emit(AuthLoading());
      final results = await authRepository.signIn(
        password: event.password,
        email: event.email,
        phone: event.phone,
      );
      results.fold((error) {
        emit(AuthError(error));
      }, (session) {
        emit(Authenticated(false));
      });
    });

    on<SocialSignInPressed>((event, emit) async {
      emit(AuthLoading());
      final results = await authRepository.signInWithProvider(event.provider);
      results.fold((error) {
        emit(AuthError(error));
      }, (_) {
        // The provider page is open (web: the page is about to navigate). The
        // session arrives through the auth state stream when it redirects
        // back, so stop the loading overlay without claiming a result.
        emit(UnAuthenticated());
      });
    });

    on<SignOutPressed>((event, emit) async {
      emit(AuthLoading());
      final results = await authRepository.signOut();
      results.fold((error) {
        emit(AuthError(error));
      }, (signedOut) {
        //commmenting this out because the auth state changes will take care of this
        //so we dont need to emit the unauthenticated state
        // emit(UnAuthenticated());
      });
    });
  }
}
