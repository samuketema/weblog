import 'package:weblog/core/error/exceptions.dart';
import 'package:weblog/core/error/failure.dart';
import 'package:weblog/core/network/connection_checker.dart';
import 'package:weblog/features/auth/data/dataSource/auth_remote_datasource.dart';
import 'package:weblog/core/common/entities/user.dart';
import 'package:weblog/features/auth/data/model/user_model.dart';
import 'package:weblog/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  final ConnectionChecker connectionChecker;
  AuthRepositoryImpl(this.remoteDatasource, this.connectionChecker);
  @override
  Future<Either<Failure, User>> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDatasource.signInWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDatasource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure("No Internet connection"));
      }
      final user = await fn();
      return right(user);
    }  on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final connected = await connectionChecker.isConnected;
      if (!connected) {
        final session = remoteDatasource.currentUserSession;
        if (session == null) {
          return left(Failure("The user is not logged in"));
        }
        return right(
          UserModel(
            name:"",
            email: session.user.email ?? '',
            id: session.user.id,
          ),
        );
      }

      final user = await remoteDatasource.getCurrentUserData();
      if (user == null) {
        return left(Failure('User is not logged in'));
      }
      return right(user); 
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
