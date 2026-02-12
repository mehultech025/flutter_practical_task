import 'package:flutter/material.dart';
import 'package:flutter_practical_task/core/app_colors.dart';
import 'package:flutter_practical_task/ui/widgets/custom_text.dart';
import 'package:flutter_practical_task/utils/constants/fonts/label_keys.dart';
import 'custom_text_field.dart';

class AddTodoBottomSheet extends StatelessWidget {
  final bool isEdit;

  const AddTodoBottomSheet({super.key, this.isEdit = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: whiteFFFFFFColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            Center(
              child: Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: textSecondaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 20),

            CustomText(
              text: isEdit ? editTaskKey : addNewTaskKey,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: black000000Color,
            ),

            const SizedBox(height: 6),

            CustomText(
              text: fillDetailsBelowKey,
              fontSize: 13,
              color: textSecondaryColor,
            ),

            const SizedBox(height: 25),

            CustomText(
              text: titleKey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),

            const SizedBox(height: 8),

            const CustomTextField(hint: enterTaskTitleKey),

            const SizedBox(height: 20),

            CustomText(
              text: descriptionKey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),

            const SizedBox(height: 8),

            const CustomTextField(hint: enterTaskTDescriptionKey, maxLines: 3),

            const SizedBox(height: 20),

            CustomText(
              text: maxTimeKey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: minutesKey,
                        fontSize: 12,
                        color: textSecondaryColor,
                      ),
                      SizedBox(height: 6),
                      CustomTextField(hint: "00"),
                    ],
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: secondKey,
                        fontSize: 12,
                        color: textSecondaryColor,
                      ),
                      SizedBox(height: 6),
                      CustomTextField(hint: "00"),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: textSecondaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: null,
                    child: const Text(
                      cancelKey,
                      style: TextStyle(color: black000000Color),
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: purple8D15FFColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: null,
                    child: Text(
                      isEdit ? updateKey : saveKey,
                      style: const TextStyle(color: whiteFFFFFFColor),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
