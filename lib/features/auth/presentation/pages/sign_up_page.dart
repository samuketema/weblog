import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weblog/core/theme/app_pallete.dart';
import 'package:weblog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:weblog/features/auth/presentation/pages/sign_in_page.dart';
import 'package:weblog/features/auth/presentation/widgets/auth_field.dart';
import 'package:weblog/features/auth/presentation/widgets/auth_gradient_button.dart';

class SignUpPage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => SignInPage());
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formkey = GlobalKey<FormState>();
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  @override
  void dispose() {
    namecontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign Up.',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              AuthField(hintText: "Name", controller: namecontroller),
              SizedBox(height: 15),
              AuthField(hintText: "Email", controller: emailcontroller),
              SizedBox(height: 15),
              AuthField(
                hintText: "Password",
                controller: passwordcontroller,
                isObscure: true,
              ),
              SizedBox(height: 20),
              AuthGradientButton(
                buttonText: "Sign Up.",
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    final email = emailcontroller.text.trim();
                    final password = passwordcontroller.text.trim();
                    final name = namecontroller.text.trim();

                    context.read<AuthBloc>().add(
                      AuthSignUp(email: email, name: name, password: password),
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(SignUpPage.route());
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
