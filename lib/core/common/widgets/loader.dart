import 'package:flutter/material.dart%20';
import 'package:flutter/widgets.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(),);
  }
}