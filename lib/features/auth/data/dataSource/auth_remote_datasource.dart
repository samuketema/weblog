import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:weblog/core/error/exceptions.dart';
import 'package:weblog/features/auth/data/model/user_model.dart';

abstract interface class AuthRemoteDatasource {

  Session? get currentUserSession;
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData() ;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDatasource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  }) async{
    try {
      final responce = await supabaseClient.auth.signInWithPassword(password: password,email: email);
      if (responce.user == null) {
        throw ServerException("User is null");
      }
      return  UserModel.fromJson(responce.user!.toJson()).copyWith(email: currentUserSession!.user.email);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
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

      return UserModel.fromJson(responce.user!.toJson()).copyWith(email: currentUserSession!.user.email);
      
    } catch (e) {
      throw ServerException(e.toString());
    }
    
  }
  
  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;
  
  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if(currentUserSession != null){
      final userData = await supabaseClient.from('profiles').select().eq('id', currentUserSession!.user.id);

     return UserModel.fromJson(userData.first).copyWith(
      email: currentUserSession!.user.email
     );
    }
      
      return null;  
    }  catch (e) {
      throw ServerException(e.toString());
    }
  }
}
