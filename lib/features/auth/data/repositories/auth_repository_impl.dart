import 'package:weblog/core/error/exceptions.dart';
import 'package:weblog/core/error/failure.dart';
import 'package:weblog/features/auth/data/dataSource/auth_remote_datasource.dart';
import 'package:weblog/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl(this.remoteDatasource);
  @override
  Future<Either<Failure, String>> signInWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement signInWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
     final userId = await remoteDatasource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(userId);
    }on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
