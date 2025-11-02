import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:weblog/core/secrets/app_secrets.dart';
import 'package:weblog/core/theme/app_theme.dart';
import 'package:weblog/features/auth/presentation/pages/sign_up_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(anonKey: AppSecrets.anonKey,url: AppSecrets.url);
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.darktheme,
      home: SignUpPage(),
    );
  }
}
