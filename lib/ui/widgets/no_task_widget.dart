import 'package:flutter/material.dart';
import 'package:flutter_practical_task/core/app_colors.dart';
import 'package:flutter_practical_task/ui/widgets/custom_text.dart';

class NoTaskWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const NoTaskWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: whiteFFFFFFColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 2,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 70,
              color: purple8D15FFColor,
            ),
            const SizedBox(height: 15),
            CustomText(
              text: title,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 8),
            CustomText(
              text: subtitle,
              fontSize: 14,
              color: textSecondaryColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}