import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urban_lens/theme.dart'; // To access ThemeManager

class AppTheme {
  // Colors
  static Color get white => ThemeManager.isDark ? const Color(0xFF16213E) : Colors.white;
  static Color get pureBlack => ThemeManager.isDark ? Colors.white : const Color(0xFF000000);
  static Color get charcoal => ThemeManager.isDark ? Colors.white : const Color(0xFF1A1A2E);
  static Color get darkGrey => ThemeManager.isDark ? const Color(0xFFA0AAB2) : const Color(0xFF6B7280);
  static Color get mediumGrey => ThemeManager.isDark ? const Color(0xFF8892A3) : const Color(0xFF9CA3AF);
  static Color get lightGrey => ThemeManager.isDark ? const Color(0xFF1A1A2E) : const Color(0xFFF3F4F6);
  static Color get primaryOrange => const Color(0xFF007FFF); // Accent keeps same

  // Radii
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 20.0;

  // Shadows
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get elevatedShadow => [
        BoxShadow(
          color: primaryOrange.withValues(alpha: 0.15),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ];

  // Input Decoration
  static InputDecoration inputDecoration({
    required String label,
    required String hint,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label.isNotEmpty ? label : null,
      hintText: hint,
      hintStyle: GoogleFonts.poppins(
        fontSize: 14,
        color: mediumGrey,
      ),
      filled: true,
      fillColor: lightGrey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: mediumGrey.withValues(alpha: 0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: primaryOrange, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      suffixIcon: suffixIcon,
    );
  }

  // Button Styles
  static ButtonStyle get primaryButton => ElevatedButton.styleFrom(
        backgroundColor: ThemeManager.isDark ? primaryOrange : pureBlack,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      );

  // Button Text Style
  static TextStyle get buttonText => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );
}
