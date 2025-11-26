import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:weblog/blog/data/datasources/blog_remote_data_source.dart';
import 'package:weblog/blog/data/repositories/blog_repository_impl.dart';
import 'package:weblog/blog/domain/repository/blog_repositroy.dart';
import 'package:weblog/blog/domain/usecases/upload_blog.dart';
import 'package:weblog/blog/presentation/bloc/blog_bloc.dart';
import 'package:weblog/core/common/app_user/cubit/app_user_cubit.dart';
import 'package:weblog/core/secrets/app_secrets.dart';
import 'package:weblog/features/auth/data/dataSource/auth_remote_datasource.dart';
import 'package:weblog/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:weblog/features/auth/domain/repositories/auth_repository.dart';
import 'package:weblog/features/auth/domain/usecase/current_user.dart';
import 'package:weblog/features/auth/domain/usecase/user_login.dart';
import 'package:weblog/features/auth/domain/usecase/user_sign_up.dart';
import 'package:weblog/features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initblog();
  final supabase = await Supabase.initialize(
    anonKey: AppSecrets.anonKey,
    url: AppSecrets.url,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

_initAuth() {
  serviceLocator.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDataSourceImpl(serviceLocator()),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));

  serviceLocator.registerFactory(() => UserSignIn(serviceLocator()));

  serviceLocator.registerFactory(() => CurrentUser(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userSignIn: serviceLocator(),
      currentUser: serviceLocator(),
      appuserCubit: serviceLocator(),
    ),
  );
}

void _initblog() {
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(supabaseClient: serviceLocator()),
    )
    ..registerFactory<BlogRepositroy>(
      () => BlogRepositoryImpl(blogRemoteDataSource: serviceLocator()),
    )
    ..registerFactory(() => UploadBlog(blogRepositroy: serviceLocator()))
    ..registerLazySingleton(() => BlogBloc(serviceLocator()));
}
