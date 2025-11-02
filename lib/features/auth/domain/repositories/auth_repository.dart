import 'package:fpdart/fpdart.dart';
import 'package:weblog/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure,String>>signUpWithEmailPassword(
   {required String name,
   required String email,
   required String password}
  );
}
