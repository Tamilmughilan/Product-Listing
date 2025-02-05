import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.transparent, 
    primarySwatch: Colors.blue,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 190, 136, 201),
      foregroundColor: Colors.white,
    ),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF007AFF),
      secondary: Color(0xFFFFA500), 
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.transparent, 
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 45, 2, 53),
      foregroundColor: Colors.white,
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF6A5ACD), 
      secondary: Color(0xFFFFC107), 
    ),
  );
}

class GradientBackground extends StatelessWidget {
  final Widget child;
  final bool isLightTheme;

  const GradientBackground({Key? key, required this.child, required this.isLightTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isLightTheme
              ? [
                  const Color.fromARGB(255, 228, 210, 233), 
                  const Color.fromARGB(255, 190, 136, 201), 
                ]
              : [
                  const Color.fromARGB(255, 48, 9, 61), 
                  const Color.fromARGB(255, 45, 2, 53),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }
}
