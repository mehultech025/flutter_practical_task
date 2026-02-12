import 'package:flutter/material.dart';
import 'package:flutter_practical_task/core/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final int maxLines;

  const CustomTextField({
    super.key,
    required this.hint,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(color: black000000Color),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: textSecondaryColor),
        filled: true,
        fillColor: textSecondaryColor.withOpacity(0.2), // light background
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}