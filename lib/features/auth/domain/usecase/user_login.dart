import 'package:fpdart/src/either.dart';
import 'package:weblog/core/error/failure.dart';
import 'package:weblog/core/usecase/usecase.dart';
import 'package:weblog/features/auth/domain/entities/user.dart';

class UserLogin implements Usecase<User,UserLogInParams> {
  @override
  Future<Either<Failure, dynamic>> call(Params) {
    // TODO: implement call
    throw UnimplementedError();
  }
  
}

class UserLogInParams{
  final String email;
  final String password;

  UserLogInParams({required this.email, required this.password});
}