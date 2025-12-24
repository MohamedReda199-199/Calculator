import 'package:flutter/material.dart';
import 'package:calculator/core/constants/app_colors.dart';

class CalculatorKeypad extends StatelessWidget {
  final Function(String)? onNumberPressed;
  final Function(String)? onOperationPressed;
  final VoidCallback? onClearPressed;
  final VoidCallback? onEqualsPressed;

  const CalculatorKeypad({
    super.key,
    this.onNumberPressed,
    this.onOperationPressed,
    this.onClearPressed,
    this.onEqualsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                _buildButton(
                  'C',
                  onClearPressed ?? () {},
                  backgroundColor: Colors.red,
                ),
                // const Spacer(),
                _buildButton(
                  '÷',
                  onOperationPressed != null
                      ? () => onOperationPressed!('÷')
                      : () {},
                  isOperator: true,
                ),
              ],
            ),
          ),
          ..._buildNumberRows(),
          // Last row: 0, ., =
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildButton(
                    '0',
                    onNumberPressed != null
                        ? () => onNumberPressed!('0')
                        : () {},
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: _buildButton(
                    '.',
                    onNumberPressed != null
                        ? () => onNumberPressed!('.')
                        : () {},
                  ),
                ),
                _buildButton(
                  '=',
                  onEqualsPressed ?? () {},
                  isOperator: true,
                  backgroundColor: AppColors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildNumberRows() {
    final List<List<String>> rows = [
      ['7', '8', '9', '×'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', '+'],
    ];

    return rows.map((row) {
      return Expanded(
        child: Row(
          children: row.map((item) {
            return _buildButton(
              item,
              onNumberPressed != null ||
                      onOperationPressed != null ||
                      onClearPressed != null ||
                      onEqualsPressed != null
                  ? () => _onButtonPressed(item)
                  : () {},
              isOperator: ['+', '-', '×', '÷'].contains(item),
            );
          }).toList(),
        ),
      );
    }).toList();
  }

  void _onButtonPressed(String buttonText) {
    if (buttonText == 'C') {
      onClearPressed?.call();
    } else if (['+', '-', '×', '÷'].contains(buttonText)) {
      onOperationPressed?.call(buttonText);
    } else {
      onNumberPressed?.call(buttonText);
    }
  }

  Widget _buildButton(
    String buttonText,
    VoidCallback onPressed, {
    bool isOperator = false,
    Color? backgroundColor,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          color:
              backgroundColor ??
              (isOperator ? AppColors.operatorButton : AppColors.button),
          borderRadius: BorderRadius.circular(8.0),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(8.0),
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 24.0,
                  color: isOperator
                      ? AppColors.operatorButtonText
                      : AppColors.buttonText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
