import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:weblog/core/error/exceptions.dart';
import 'package:weblog/core/error/failure.dart';
import 'package:weblog/features/auth/data/dataSource/auth_remote_datasource.dart';
import 'package:weblog/features/auth/domain/entities/user.dart';
import 'package:weblog/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl(this.remoteDatasource);
  @override
  Future<Either<Failure, User>> signInWithEmailPassword({
    required String email,
    required String password,
  })async  {
   return _getUser(() async=> await remoteDatasource.signInWithEmailPassword(email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async=> await remoteDatasource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ) 
    
    );

  }
  Future<Either<Failure,User>> _getUser ( Future<User> Function() fn) async {
    try {
     final user = await fn();
      return right(user);
    }on sb.AuthException catch(e){
      return left(Failure(e.message)); 
    }
    
     on ServerException catch (e) {
      return left(Failure(e.message));
    }
     catch (e) {
  return left(Failure(e.toString()));
}
  }
  
  @override
  Future<Either<Failure, User>> currentUser() async{
   try {
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
