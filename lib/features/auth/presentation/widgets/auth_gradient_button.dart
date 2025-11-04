import 'package:flutter/material.dart';
import 'package:weblog/core/theme/app_pallete.dart';

class AuthGradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  const AuthGradientButton({super.key , required this.buttonText,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          gradient: LinearGradient(
            colors: [
              AppPallete.gradient1,
              AppPallete.gradient2,
              AppPallete.gradient3,
            ],
            begin: AlignmentGeometry.bottomLeft,
            end: AlignmentGeometry.topRight,
          ),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(395, 55),
            backgroundColor: AppPallete.transparentColor,
            shadowColor: AppPallete.transparentColor,
          ),
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
