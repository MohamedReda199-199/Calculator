import 'package:flutter/material.dart';
import 'package:calculator/core/constants/app_colors.dart';
import '../widgets/calculator_display.dart';
import '../widgets/calculator_keypad.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Display
            Expanded(
              flex: 2,
              child: CalculatorDisplay(
                value: '0',
              ),
            ),
            // Keypad
            const Expanded(
              flex: 5,
              child: CalculatorKeypad(),
            ),
          ],
        ),
      ),
    );
  }
}
