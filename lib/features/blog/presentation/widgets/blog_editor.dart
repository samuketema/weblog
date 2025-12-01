import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  const BlogEditor({super.key, required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      validator: (value){
        if (value!.trim().isEmpty) {
          return "$hint is missing";  
        }
        return null;
      },
      maxLines: null,
      controller: controller,
      decoration: InputDecoration(hintText: hint),
    );
  }
}
