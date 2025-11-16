import 'package:fpdart/fpdart.dart';
import 'package:weblog/core/error/failure.dart';
import 'package:weblog/core/usecase/usecase.dart';
import 'package:weblog/core/common/entities/user.dart';
import 'package:weblog/features/auth/domain/repositories/auth_repository.dart';

class UserSignIn implements Usecase<User,UaserSignInParams> {
 final AuthRepository authRepository;
  UserSignIn (this.authRepository);
  @override
  Future<Either<Failure, User>> call(UaserSignInParams Params) async {
    return await authRepository.signInWithEmailPassword(
      email: Params.email,  
      password: Params.password,
    );
  }
}

class UaserSignInParams{
  final String email;
  final String password;
  UaserSignInParams({required this.email, required this.password});
}