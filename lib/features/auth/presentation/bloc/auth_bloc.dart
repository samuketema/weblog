import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weblog/core/usecase/usecase.dart';
import 'package:weblog/features/auth/domain/entities/user.dart';
import 'package:weblog/features/auth/domain/usecase/current_user.dart';
import 'package:weblog/features/auth/domain/usecase/user_login.dart';
import 'package:weblog/features/auth/domain/usecase/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
  }) : _userSignUp = userSignUp,
       _userSignIn = userSignIn,
       _currentUser = currentUser,
       super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      final res = await _userSignUp(
        UserSignUpParams(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );

      res.fold(
        (l) => emit(AuthFailure(message: l.message)),
        (user) => emit(AuthSuccess(user: user)),
      );
    });
    on<AuthSignIn>((event, emit) async {
      emit(AuthLoading());
      final res = await _userSignIn(
        UaserSignInParams(email: event.email, password: event.password),
      );
      res.fold(
        (l) => emit(AuthFailure(message: l.message)),
        (user) {
          
          emit(AuthSuccess(user: user));
        },
      );
    });
    on<AuthIsUserLoggedIn>((event, emit) async {
      final res = await _currentUser(NoParams());
      res.fold(
        (l) => emit(AuthFailure(message: l.message)),
        (r) {
          print('this is data');
          print(r.email);
          emit(AuthSuccess(user: r));
        },
      );
    });
  }
}
