import 'package:flutter/material.dart';
import 'package:calculator/core/constants/app_colors.dart';
import 'package:calculator/features/calculator/presentation/pages/calculator_screen.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.accent,
          surface: AppColors.surface,
          onPrimary: AppColors.onPrimary,
          onSurface: AppColors.onSurface,
        ),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}