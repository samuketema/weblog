import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
   final String hintText;
  const AuthField( {super.key,  required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      decoration: InputDecoration(
        hintText: hintText
      ),
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