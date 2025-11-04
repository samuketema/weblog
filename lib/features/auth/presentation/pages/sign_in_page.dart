import 'package:flutter/material.dart';
import 'package:weblog/core/theme/app_pallete.dart';
import 'package:weblog/features/auth/presentation/pages/sign_up_page.dart';
import 'package:weblog/features/auth/presentation/widgets/auth_field.dart';
import 'package:weblog/features/auth/presentation/widgets/auth_gradient_button.dart';

class SignInPage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => SignUpPage());
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formkey,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign In.',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              AuthField(hintText: "Email", controller: emailcontroller),
              SizedBox(height: 15),
              AuthField(hintText: "Password", controller: passwordcontroller),
              SizedBox(height: 20),
              AuthGradientButton(buttonText: "Sign In.", onPressed: () {}),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(SignInPage.route());
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: AppPallete.gradient2,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
