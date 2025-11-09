import 'package:weblog/core/error/failure.dart';
import 'package:weblog/core/usecase/usecase.dart';
import 'package:weblog/features/auth/domain/entities/user.dart';
import 'package:weblog/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements Usecase<User, UserSignUpParams> {
 final AuthRepository authRepository;
  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignUpParams Params) async {
    return await authRepository.signUpWithEmailPassword(
      name: Params.name,
      email: Params.email,  
      password: Params.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
