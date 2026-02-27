import 'package:flutter/material.dart';
import 'package:urban_lens/theme.dart';
import 'package:urban_lens/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeManager.themeNotifier,
      builder: (context, currentMode, _) {
        return MaterialApp(
          title: 'Urban Lens',
          debugShowCheckedModeBanner: false,
          theme: UrbanTheme.theme, // Theme builds based on ThemeManager.isDark dynamically
          home: const SplashScreen(),
        );
      },
    );
  }
}
