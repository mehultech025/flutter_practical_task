import 'package:flutter/material.dart';
import 'package:flutter_practical_task/core/app_colors.dart';
import 'package:flutter_practical_task/ui/widgets/control_button.dart';
import 'package:flutter_practical_task/ui/widgets/custom_text.dart';
import 'package:flutter_practical_task/utils/constants/fonts/label_keys.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldF5F5F7Color,
      appBar: AppBar(
        backgroundColor: whiteFFFFFFColor,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: taskDetailsKey,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimaryColor,
        ),
        iconTheme: const IconThemeData(color: textPrimaryColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: whiteFFFFFFColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: shadow000000Color,
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: titleKey,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: textPrimaryColor,
                          ),
                          const SizedBox(height: 8),
                          CustomText(
                            text: dummyDecKey,
                            fontSize: 14,
                            color: textSecondaryColor,
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: progressBgColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: CustomText(
                              text: inProgressStatusKey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: purple8D15FFColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    Center(
                      child: Column(
                        children: [
                          CustomText(
                            text: "00 : 12 : 45",
                            fontSize: 42,
                            fontWeight: FontWeight.w700,
                            color: textPrimaryColor,
                          ),
                          SizedBox(height: 6),
                          CustomText(
                            text: runningTimerKey,
                            fontSize: 14,
                            color: textSecondaryColor,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ControlButton(
                          icon: Icons.play_arrow,
                          label: playStatusKey,
                          color: blue007AFFColor,
                          onTap: () {},
                        ),
                        ControlButton(
                          icon: Icons.pause,
                          label: pauseStatusKey,
                          color: purple8D15FFColor,
                          onTap: () {},
                        ),
                        ControlButton(
                          icon: Icons.stop,
                          label: stopStatusKey,
                          color: redFF3B30Color,
                          onTap: () {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: purple8D15FFColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                onPressed: () {},
                icon: const Icon(Icons.edit, color: whiteFFFFFFColor),
                label: CustomText(
                  text: editTaskKey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: whiteFFFFFFColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
