import 'package:flutter/foundation.dart';

import '../../domain/calculate_two_numbers.dart';
import '../../domain/calculator_operation.dart';

class CalculatorController extends ChangeNotifier {
  CalculatorController({CalculateTwoNumbers? calculateTwoNumbers})
    : _calculateTwoNumbers = calculateTwoNumbers ?? const CalculateTwoNumbers();

  final CalculateTwoNumbers _calculateTwoNumbers;

  String _input = '';
  double? _left;
  CalculatorOperation? _operation;
  bool _error = false;

  String get display {
    if (_error) return 'Error';
    if (_input.isNotEmpty) return _input;
    if (_left != null) return _format(_left!);
    return '0';
  }

  void onDigitPressed(int digit) {
    if (digit < 0 || digit > 9) return;

    if (_error) {
      _clearAll();
    }

    if (_input == '0') {
      _input = digit.toString();
    } else {
      _input = '$_input$digit';
    }

    notifyListeners();
  }

  void onClearPressed() {
    _clearAll();
    notifyListeners();
  }

  void onOperationPressed(CalculatorOperation operation) {
    if (_error) {
      _clearAll();
    }

    if (_input.isEmpty && _left != null) {
      _operation = operation;
      notifyListeners();
      return;
    }

    final parsed = _tryParseInput();
    if (parsed == null) {
      notifyListeners();
      return;
    }

    if (_left == null) {
      _left = parsed;
      _operation = operation;
      _input = '';
      notifyListeners();
      return;
    }

    if (_operation == null) {
      _operation = operation;
      _input = '';
      notifyListeners();
      return;
    }

    _computeWithRight(parsed);
    if (!_error) {
      _operation = operation;
      _input = '';
    }

    notifyListeners();
  }

  void onEqualsPressed() {
    if (_error) {
      _clearAll();
      notifyListeners();
      return;
    }

    if (_left == null || _operation == null) {
      notifyListeners();
      return;
    }

    final right = _tryParseInput();
    if (right == null) {
      notifyListeners();
      return;
    }

    _computeWithRight(right);
    if (!_error) {
      _operation = null;
      _input = '';
    }

    notifyListeners();
  }

  double? _tryParseInput() {
    if (_input.isEmpty) return null;
    return double.tryParse(_input);
  }

  void _computeWithRight(double right) {
    try {
      _left = _calculateTwoNumbers(
        left: _left!,
        right: right,
        operation: _operation!,
      );
      _error = false;
    } catch (_) {
      _left = null;
      _operation = null;
      _input = '';
      _error = true;
    }
  }

  void _clearAll() {
    _input = '';
    _left = null;
    _operation = null;
    _error = false;
  }

  String _format(double value) {
    final asInt = value.toInt();
    if (asInt.toDouble() == value) {
      return asInt.toString();
    }
    return value.toString();
  }
}
