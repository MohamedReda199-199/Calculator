import 'package:flutter/material.dart';
import 'package:calculator/core/constants/app_colors.dart';

class CalculatorDisplay extends StatelessWidget {
  final String value;
  
  const CalculatorDisplay({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      alignment: Alignment.bottomRight,
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 48.0,
          fontWeight: FontWeight.bold,
          color: AppColors.onSurface,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
