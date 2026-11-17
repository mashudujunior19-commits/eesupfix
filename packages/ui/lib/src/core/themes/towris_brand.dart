import 'package:flutter/material.dart';

abstract final class TowrisBrand {
  static const Color deepGreen = Color(0xFF14532D);
  static const Color green = Color(0xFF2E8B57);
  static const Color lightGreen = Color(0xFF8CC63F);
  // Dark-green night palette used by the landing video and the sign-in header.
  static const Color night = Color(0xFF001A19);
  static const Color nightGlow = Color(0xFF126E47);
  static const Color neon = Color(0xFF81F80A);
  static const Color mint = Color(0xFFE6F5EA);
  static const Color ink = Color(0xFF1A1F1C);
  static const Color field = Color(0xFFF2F1EB);
  static const String name = 'Towris';
  static const String slogan = 'OWN YOUR ECONOMY';

  static const LinearGradient gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [deepGreen, green, lightGreen],
  );
}
