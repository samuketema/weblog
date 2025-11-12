import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weblog/features/auth/domain/entities/user.dart';
import 'package:weblog/features/auth/domain/usecase/user_login.dart';
import 'package:weblog/features/auth/domain/usecase/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
 final UserSignUp _userSignUp;
 final UserSignIn _userSignIn;
  AuthBloc({required UserSignUp userSignUp, required UserSignIn userSignIn})
    : _userSignUp = userSignUp,
    _userSignIn = userSignIn,
      super(AuthInitial()) {
    on<AuthSignUp>((event, emit)async {
      emit(AuthLoading());
   final res = await  _userSignUp(
        UserSignUpParams(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );
  
      res.fold((l)=> emit(AuthFailure(message:l.message))
      , (user)=> emit(AuthSuccess(user: user)));
    });
   on<AuthSignIn>((event, emit)async {
     emit(AuthLoading());
     final res = await _userSignIn(UaserSignInParams(email: event.email, password: event.password));
     res.fold((l)=> emit(AuthFailure(message:l.message))
      , (user)=> emit(AuthSuccess(user: user)));
   },);
  }
}
