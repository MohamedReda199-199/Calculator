import 'package:flutter/material.dart';

import '../../domain/calculator_operation.dart';
import 'calculator_controller.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  late final CalculatorController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalculatorController()..addListener(_onChanged);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onChanged)
      ..dispose();
    super.dispose();
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _Display(text: _controller.display),
              const SizedBox(height: 16),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          _DigitButton(
                            text: '7',
                            onPressed: () => _controller.onDigitPressed(7),
                          ),
                          _DigitButton(
                            text: '8',
                            onPressed: () => _controller.onDigitPressed(8),
                          ),
                          _DigitButton(
                            text: '9',
                            onPressed: () => _controller.onDigitPressed(9),
                          ),
                          _OpButton(
                            text: '+',
                            onPressed: () => _controller.onOperationPressed(
                              CalculatorOperation.add,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          _DigitButton(
                            text: '4',
                            onPressed: () => _controller.onDigitPressed(4),
                          ),
                          _DigitButton(
                            text: '5',
                            onPressed: () => _controller.onDigitPressed(5),
                          ),
                          _DigitButton(
                            text: '6',
                            onPressed: () => _controller.onDigitPressed(6),
                          ),
                          _OpButton(
                            text: '-',
                            onPressed: () => _controller.onOperationPressed(
                              CalculatorOperation.subtract,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          _DigitButton(
                            text: '1',
                            onPressed: () => _controller.onDigitPressed(1),
                          ),
                          _DigitButton(
                            text: '2',
                            onPressed: () => _controller.onDigitPressed(2),
                          ),
                          _DigitButton(
                            text: '3',
                            onPressed: () => _controller.onDigitPressed(3),
                          ),
                          _OpButton(
                            text: '*',
                            onPressed: () => _controller.onOperationPressed(
                              CalculatorOperation.multiply,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          _DigitButton(
                            text: '0',
                            onPressed: () => _controller.onDigitPressed(0),
                          ),
                          _ActionButton(
                            text: '=',
                            background: scheme.primary,
                            foreground: scheme.onPrimary,
                            onPressed: _controller.onEqualsPressed,
                          ),
                          _ActionButton(
                            text: 'C',
                            background: scheme.errorContainer,
                            foreground: scheme.onErrorContainer,
                            onPressed: _controller.onClearPressed,
                          ),
                          _OpButton(
                            text: '/',
                            onPressed: () => _controller.onOperationPressed(
                              CalculatorOperation.divide,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Display extends StatelessWidget {
  const _Display({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        textAlign: TextAlign.right,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
      ),
    );
  }
}

class _DigitButton extends StatelessWidget {
  const _DigitButton({required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _ActionButton(
      text: text,
      background: scheme.surfaceContainerHighest,
      foreground: scheme.onSurface,
      onPressed: onPressed,
    );
  }
}

class _OpButton extends StatelessWidget {
  const _OpButton({required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _ActionButton(
      text: text,
      background: scheme.secondaryContainer,
      foreground: scheme.onSecondaryContainer,
      onPressed: onPressed,
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.text,
    required this.background,
    required this.foreground,
    required this.onPressed,
  });

  final String text;
  final Color background;
  final Color foreground;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: SizedBox.expand(
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: background,
              foregroundColor: foreground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: Theme.of(context).textTheme.headlineSmall,
            ),
            onPressed: onPressed,
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
