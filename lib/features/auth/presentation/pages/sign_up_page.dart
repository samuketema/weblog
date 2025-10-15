import 'package:flutter/material.dart';
import 'package:weblog/features/auth/presentation/widgets/auth_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'SignUp.',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20,),
          AuthField(hintText: "name",),
          SizedBox(height: 20,),
          AuthField(hintText: "email",),
          SizedBox(height: 20,),
          AuthField(hintText: "password",)
          
        ],
      ),
    );
  }
}
