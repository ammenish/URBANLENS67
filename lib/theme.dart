import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
  static bool get isDark => themeNotifier.value == ThemeMode.dark;
  static void toggleTheme(bool dark) {
    themeNotifier.value = dark ? ThemeMode.dark : ThemeMode.light;
  }
}

class UrbanTheme {
  // Primary Colors
  static Color get primaryBlue => ThemeManager.isDark ? Colors.white : const Color(0xFF0B1B3D);
  static Color get primaryYellow => const Color(0xFF007FFF); // Accent keeps same
  static Color get backgroundLight => ThemeManager.isDark ? const Color(0xFF1A1A2E) : const Color(0xFFF5F6F8);
  static Color get textDark => ThemeManager.isDark ? Colors.white : const Color(0xFF0B1B3D);
  static Color get textLight => ThemeManager.isDark ? const Color(0xFFA0AAB2) : const Color(0xFF8892A3);
  static Color get cardWhite => ThemeManager.isDark ? const Color(0xFF16213E) : Colors.white;

  // Extended Palette
  static Color get successGreen => const Color(0xFF2ECC71);
  static Color get darkNavy => ThemeManager.isDark ? Colors.white : const Color(0xFF0A1628);
  static Color get mediumBlue => ThemeManager.isDark ? const Color(0xFF2A3D60) : const Color(0xFF1A2D50);
  static Color get accentOrange => const Color(0xFFFF8C00);
  static Color get lightYellow => ThemeManager.isDark ? const Color(0xFF0F3460) : const Color(0xFFE6F2FF);
  static Color get borderGrey => ThemeManager.isDark ? const Color(0xFF2A2A40) : const Color(0xFFE8ECF0);
  static Color get subtitleGrey => ThemeManager.isDark ? const Color(0xFFB0B0B0) : const Color(0xFF6B7280);

  static ThemeData get theme {
    return ThemeData(
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: backgroundLight,
      colorScheme: ColorScheme(
        brightness: ThemeManager.isDark ? Brightness.dark : Brightness.light,
        primary: primaryBlue,
        onPrimary: ThemeManager.isDark ? const Color(0xFF0B1B3D) : Colors.white,
        secondary: primaryYellow,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        surface: cardWhite,
        onSurface: textDark,
      ),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.bold, color: textDark),
        displayMedium: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: textDark),
        bodyLarge: GoogleFonts.inter(fontSize: 16, color: textDark),
        bodyMedium: GoogleFonts.inter(fontSize: 14, color: textLight),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundLight,
        elevation: 0,
        iconTheme: IconThemeData(color: textDark),
        titleTextStyle: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: textDark),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ThemeManager.isDark ? const Color(0xFF16213E) : primaryBlue,
        selectedItemColor: primaryYellow,
        unselectedItemColor: ThemeManager.isDark ? Colors.grey : Colors.white,
      ),
    );
  }
}
