import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:weblog/core/secrets/app_secrets.dart';
import 'package:weblog/features/auth/data/dataSource/auth_remote_datasource.dart';
import 'package:weblog/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:weblog/features/auth/domain/repositories/auth_repository.dart';
import 'package:weblog/features/auth/domain/usecase/user_sign_up.dart';
import 'package:weblog/features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  
  final supabase = await Supabase.initialize(
    anonKey: AppSecrets.anonKey,
    url: AppSecrets.url,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);
   _initAuth();
}

_initAuth() {
  serviceLocator.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDataSourceImpl(serviceLocator()),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));
  
  serviceLocator.registerLazySingleton(
    () => AuthBloc(userSignUp: serviceLocator()),
  );
}
