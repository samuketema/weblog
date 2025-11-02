import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:weblog/core/error/exceptions.dart';

abstract interface class AuthRemoteDatasource {
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<String> signInWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRepositoryImpl implements AuthRemoteDatasource {
  SupabaseClient supabaseClient;

  AuthRepositoryImpl(this.supabaseClient);
  @override
  Future<String> signInWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement signInWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse responce = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {"name": name},
      );
      if (responce.user == null) {
        throw ServerException("User is null");
      }

      return responce.user!.id;
      
    } catch (e) {
      throw ServerException(e.toString());
    }
    
  }
}
