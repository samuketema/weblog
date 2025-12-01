import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weblog/core/common/widgets/loader.dart';
import 'package:weblog/core/theme/app_pallete.dart';
import 'package:weblog/core/utils/show_snakbar.dart';
import 'package:weblog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:weblog/features/auth/presentation/pages/sign_up_page.dart';
import 'package:weblog/features/auth/presentation/widgets/auth_field.dart';
import 'package:weblog/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:weblog/features/blog/presentation/pages/blog_page.dart';

class SignInPage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const SignInPage());
  
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
      backgroundColor: AppPallete.backgroundColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnakbar(context, state.message);
          } else if (state is AuthSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const BlogPage()), 
              (Route route) => false
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Header Section
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: AppPallete.mainGradient,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.lock_open_rounded,
                              size: 40,
                              color: AppPallete.whiteColor,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Welcome Back',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: AppPallete.textPrimary,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Sign in to continue your journey',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppPallete.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 40),
                      
                      // Form Section
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppPallete.backgroundLight,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppPallete.borderColor,
                            width: 1,
                          ),
                        ),
                        child: Form(
                          key: formkey,
                          child: Column(
                            children: [
                              AuthField(
                                hintText: "Email",
                                controller: emailcontroller,
                                
                              ),
                              const SizedBox(height: 16),
                              AuthField(
                                hintText: "Password",
                                controller: passwordcontroller,
                                isObscure: true,
                                
                              ),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    // Add forgot password functionality
                                  },
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      color: AppPallete.gradient2,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              AuthGradientButton(
                                buttonText: "Sign In",
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    final email = emailcontroller.text.trim();
                                    final password = passwordcontroller.text.trim();

                                    context.read<AuthBloc>().add(
                                      AuthSignIn(email: email, password: password),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Footer Section
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppPallete.borderLight,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'OR',
                              style: TextStyle(
                                color: AppPallete.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: AppPallete.borderLight,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(SignUpPage.route());
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Don\'t have an account? ',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppPallete.textSecondary,
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  fontSize: 16,
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
            ),
          );
        },
      ),
    );
  }
}