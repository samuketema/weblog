import 'package:fpdart/fpdart.dart';
import 'package:weblog/core/error/failure.dart';
import 'package:weblog/core/usecase/usecase.dart';
import 'package:weblog/core/common/entities/user.dart';
import 'package:weblog/features/auth/domain/repositories/auth_repository.dart';

class CurrentUser implements Usecase<User,NoParams>{
  final AuthRepository authRepository;
  CurrentUser( this.authRepository);
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
   return await authRepository.currentUser();
  }
}

