import 'package:flutter/material.dart';
import 'package:flutter_practical_task/core/app_colors.dart';
import 'package:flutter_practical_task/ui/widgets/custom_text.dart';
import 'package:flutter_practical_task/utils/constants/fonts/fonts_weight.dart';
import 'package:flutter_practical_task/utils/constants/fonts/label_keys.dart';

class StatusChip extends StatelessWidget {
  final String status;

  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;


    switch (status) {
      case inProgressStatusKey:
        bgColor = purple8D15FFColor;
        break;
      case doneStatusKey:
        bgColor = green30D158Color;
        break;
      case pausedStatusKey:
        bgColor = Colors.orange;
        break;
      default:
        bgColor = blue007AFFColor;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: CustomText(
        text: status,
        fontSize: 12,
        color: bgColor,
        fontWeight: semiBold,
      ),
    );
  }
}