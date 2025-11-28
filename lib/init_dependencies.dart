import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:weblog/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:weblog/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:weblog/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:weblog/features/blog/domain/repository/blog_repositroy.dart';
import 'package:weblog/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:weblog/features/blog/domain/usecases/upload_blog.dart';
import 'package:weblog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:weblog/core/common/app_user/cubit/app_user_cubit.dart';
import 'package:weblog/core/network/connection_checker.dart';
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
  // 1️⃣ Initialize Hive for Flutter
  await Hive.initFlutter();
  
  // 2️⃣ Open Hive box
  final blogsBox = await Hive.openBox('blogs');
  serviceLocator.registerLazySingleton(() => blogsBox);

  // 3️⃣ Initialize Supabase
  final supabase = await Supabase.initialize(
    url: AppSecrets.url,
    anonKey: AppSecrets.anonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  // 4️⃣ Other common dependencies
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(internetConnection: serviceLocator()),
  );

  // 5️⃣ Initialize features
  _initAuth();
  _initBlog();
}

// ----------------- AUTH -----------------
void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDataSourceImpl(serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator(), serviceLocator()),
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

// ----------------- BLOG -----------------
void _initBlog() {
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(supabaseClient: serviceLocator()),
    )
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImpl(box: serviceLocator()),
    )
    ..registerFactory<BlogRepositroy>(
      () => BlogRepositoryImpl(
        blogRemoteDataSource: serviceLocator(),
        connectionChecker: serviceLocator(),
        blogLocalDataSource: serviceLocator(),
      ),
    )
    ..registerFactory(() => UploadBlog(blogRepositroy: serviceLocator()))
    ..registerFactory(() => GetAllBlogs(blogRepositroy: serviceLocator()))
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        getAllBlogs: serviceLocator(),
      ),
    );
}