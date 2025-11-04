import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final bool isObscure;
  final TextEditingController controller;
  final String hintText;
  const AuthField({
    super.key,
    this.isObscure = false,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(hintText: hintText),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is misssing";
        } else {
          return null;
        }
      },
    );
  }
}
