import 'package:bloc/bloc.dart';
import 'package:eesup_repository/auth/auth_repository.dart';
import 'package:eesup_repository/core/eesup_exception.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthBlocState> {
  final AuthRepository _authRepository;
  AuthBloc(this._authRepository) : super(UnAuthenticated()) {
    on<AppStarted>((event, emit) async {
      await emit.forEach(_authRepository.authStateChanges, onData: (event) {
        final session = event.session;
        if (session == null) {
          return UnAuthenticated();
        } else {
          return Authenticated(true);
        }
      });
    });

    on<SignInPressed>((event, emit) async {
      emit(AuthLoading());
      final results = await _authRepository.signIn(
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

    on<SignOutPressed>((event, emit) async {
      emit(AuthLoading());
      final results = await _authRepository.signOut();
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
