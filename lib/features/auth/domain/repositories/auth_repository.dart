import 'package:fpdart/fpdart.dart';
import 'package:weblog/core/error/failure.dart';

abstract interface class AuthRepository {
  Either<Failure, String> signInWithEmailPassword({
    required String email,
    required String password,
  });

  signUpWithEmailPassword(
   {required String name,
   required String email,
   required String password}
  );
}
