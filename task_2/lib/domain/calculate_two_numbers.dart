import 'calculator_operation.dart';

class CalculateTwoNumbers {
  const CalculateTwoNumbers();

  double call({
    required double left,
    required double right,
    required CalculatorOperation operation,
  }) {
    switch (operation) {
      case CalculatorOperation.add:
        return left + right;
      case CalculatorOperation.subtract:
        return left - right;
      case CalculatorOperation.multiply:
        return left * right;
      case CalculatorOperation.divide:
        if (right == 0) {
          throw const IntegerDivisionByZeroException();
        }
        return left / right;
    }
  }
}
