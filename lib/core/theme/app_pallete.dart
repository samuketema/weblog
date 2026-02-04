
import 'package:flutter/material.dart';

class AppPallete {
  // Background & Surface
  static const Color backgroundColor = Color(0xFF0F172A);
  static const Color backgroundLight = Color(0xFF1E293B);
  static const Color backgroundDark = Color(0xFF020617);
  
  // Primary Gradient Colors
  static const Color gradient1 = Color(0xFF0B9488); // Teal
  static const Color gradient2 = Color(0xFF10A981); // Emerald
  static const Color gradient3 = Color(0xFF84AC16); // Lime
  
  // Semantic Colors
  static const Color primary = gradient1;
  static const Color secondary = Color(0xFF8B5CF6); // Violet
  static const Color accent = Color(0xFFF59E0B); // Amber
  
  // UI Colors
  static const Color borderColor = Color(0xFF334155);
  static const Color borderLight = Color(0xFF475569);
  static const Color whiteColor = Colors.white;
  static const Color greyColor = Color(0xFF94A3B8);
  
  // Status Colors
  static const Color successColor = Color(0xFF22C55E);
  static const Color errorColor = Color(0xFFEF4444);
  static const Color warningColor = Color(0xFFEAB308);
  static const Color infoColor = Color(0xFF3B82F6);
  
  // Text Colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFCBD5E1);
  static const Color textDisabled = Color(0xFF64748B);
  
  static const Color transparentColor = Colors.transparent;

  static LinearGradient get mainGradient => const LinearGradient(
        colors: [gradient1, gradient2, gradient3],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}