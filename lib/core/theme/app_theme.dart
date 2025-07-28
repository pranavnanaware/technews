import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Color Palette
  static const Color primaryColor = Color(0xFF00D4FF);
  static const Color secondaryColor = Color(0xFF7C3AED);
  static const Color backgroundColor = Color(0xFF0F1419);
  static const Color surfaceColor = Color(0xFF1A1D23);
  static const Color cardColor = Color(0xFF242930);
  static const Color borderColor = Color(0xFF2D3139);
  
  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B3B8);
  static const Color textTertiary = Color(0xFF65676B);
  
  // Status Colors
  static const Color successColor = Color(0xFF10B981);
  static const Color errorColor = Color(0xFFEF4444);
  static const Color warningColor = Color(0xFFF59E0B);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [backgroundColor, Color(0xFF1A1D23)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static ThemeData get lightTheme {
    return _buildTheme(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      backgroundColor: Colors.white,
      surfaceColor: Colors.grey[50]!,
      textColor: Colors.black87,
    );
  }

  static ThemeData get darkTheme {
    return _buildTheme(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      backgroundColor: backgroundColor,
      surfaceColor: surfaceColor,
      textColor: textPrimary,
    );
  }

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color primaryColor,
    required Color backgroundColor,
    required Color surfaceColor,
    required Color textColor,
  }) {
    final textTheme = GoogleFonts.interTextTheme().apply(
      bodyColor: textColor,
      displayColor: textColor,
    );

    return ThemeData(
      brightness: brightness,
      useMaterial3: true,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: brightness,
        surface: surfaceColor,
        background: backgroundColor,
      ),

      textTheme: textTheme.copyWith(
        displayLarge: textTheme.displayLarge?.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        displayMedium: textTheme.displayMedium?.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: -0.25,
        ),
        displaySmall: textTheme.displaySmall?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
        ),
        headlineLarge: textTheme.headlineLarge?.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: -0.25,
        ),
        headlineMedium: textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
        ),
        headlineSmall: textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
        ),
        titleLarge: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
        ),
        titleMedium: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
        titleSmall: textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
        bodyLarge: textTheme.bodyLarge?.copyWith(
          letterSpacing: 0.5,
        ),
        bodyMedium: textTheme.bodyMedium?.copyWith(
          letterSpacing: 0.25,
        ),
        bodySmall: textTheme.bodySmall?.copyWith(
          letterSpacing: 0.4,
        ),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        iconTheme: IconThemeData(color: textColor),
      ),

      cardTheme: CardTheme(
        color: brightness == Brightness.dark ? cardColor : Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: brightness == Brightness.dark ? borderColor : Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: brightness == Brightness.dark ? surfaceColor : Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: brightness == Brightness.dark ? borderColor : Colors.grey[300]!,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: brightness == Brightness.dark ? borderColor : Colors.grey[300]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: brightness == Brightness.dark ? textTertiary : Colors.grey[600],
        ),
      ),

      dividerTheme: DividerThemeData(
        color: brightness == Brightness.dark ? borderColor : Colors.grey[200],
        thickness: 1,
        space: 1,
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: brightness == Brightness.dark ? surfaceColor : Colors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: brightness == Brightness.dark ? textTertiary : Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}