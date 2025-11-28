import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weblog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:weblog/features/blog/presentation/pages/blog_page.dart';
import 'package:weblog/core/common/app_user/cubit/app_user_cubit.dart';
import 'package:weblog/core/theme/app_theme.dart';
import 'package:weblog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:weblog/features/auth/presentation/pages/sign_up_page.dart';
import 'package:weblog/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<BlogBloc>()),
      ],
      child: const MyApp(),
    ), 
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darktheme,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return BlogPage();
          }
          return SignUpPage();
        },
      ),
    );
  }
}
