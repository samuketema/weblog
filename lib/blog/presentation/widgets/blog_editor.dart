import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  final hint;
  final TextEditingController controller;
  const BlogEditor({super.key, required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: null,
      controller: controller,
      decoration: InputDecoration(hintText: hint),
    );
  }
}
