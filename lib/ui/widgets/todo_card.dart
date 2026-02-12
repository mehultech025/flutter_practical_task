import 'package:flutter/material.dart';
import 'package:flutter_practical_task/core/app_colors.dart';
import 'package:flutter_practical_task/ui/widgets/custom_text.dart';
import 'package:flutter_practical_task/utils/constants/fonts/label_keys.dart';
import 'status_chip.dart';

class TodoCard extends StatelessWidget {
  final String title;
  final String description;
  final String status;
  final String timer;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const TodoCard({
    super.key,
    required this.title,
    required this.description,
    required this.status,
    required this.timer,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
  });

  Color _getStatusColor() {
    switch (status) {
      case inProgressStatusKey:
        return purple8D15FFColor;
      case doneStatusKey:
        return green30D158Color;
      default:
        return blue007AFFColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        decoration: BoxDecoration(
          color: whiteFFFFFFColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: shadow000000Color,
              blurRadius: 14,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [

            Container(
              width: 6,
              height: 120,
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomText(
                            text: title,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: textPrimaryColor,
                          ),
                        ),
                        PopupMenuButton<String>(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          color: whiteFFFFFFColor,
                          elevation: 8,
                          offset: const Offset(0, 40),
                          icon: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: scaffoldF5F5F7Color,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.more_vert,
                              size: 20,
                              color: textSecondaryColor,
                            ),
                          ),
                          onSelected: (value) {
                            if (value == 'edit') {
                              onEdit();
                            } else if (value == 'delete') {
                              onDelete();
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: const [
                                  Icon(Icons.edit, size: 18, color: blue007AFFColor),
                                  SizedBox(width: 10),
                                  Text(editTaskKey),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: const [
                                  Icon(Icons.delete_outline,
                                      size: 18, color: redFF3B30Color),
                                  SizedBox(width: 10),
                                  Text(deleteKey),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),

                    const SizedBox(height: 8),

                    CustomText(
                      text: description,
                      fontSize: 13,
                      color: textSecondaryColor,
                      maxLines: 2,
                    ),

                    const SizedBox(height: 14),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        StatusChip(status: status),
                        Row(
                          children: [
                            const Icon(Icons.timer_outlined,
                                size: 18,
                                color: textSecondaryColor),
                            const SizedBox(width: 6),
                            CustomText(
                              text: timer,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: textPrimaryColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}