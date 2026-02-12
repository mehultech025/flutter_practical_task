import 'package:flutter/material.dart';

class OnboardingSubtitle extends StatelessWidget {
  final String text;

  const OnboardingSubtitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final parts = text.split('\n');
    final firstLine = parts.first;
    final remaining =
    parts.length > 1 ? parts.sublist(1).join('\n') : '';

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "$firstLine\n",
            style: const TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          TextSpan(
            text: remaining,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}