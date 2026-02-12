import 'package:flutter/material.dart';
import 'package:flutter_practical_task/utils/constants.dart';
import 'onboarding_subtitle.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardItem item;
  final int pageIndex;
  final int activePage;


  const OnboardingPage({
    super.key,
    required this.item,
    required this.pageIndex,
    required this.activePage,

  });

  @override
  Widget build(BuildContext context) {
    bool showSubtitle = activePage == pageIndex;
    return AnimatedAlign(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      alignment: showSubtitle
          ? const Alignment(0, -0.15)
          : const Alignment(0, 0.3),
      child: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 400),
              style: TextStyle(
                fontSize: showSubtitle ? 26 : 30,
                fontWeight: FontWeight.bold,
                color: showSubtitle ? Colors.black : Colors.white,
              ),
              child: Text(item.title),
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: showSubtitle ? 20 : 0,
            ),

            AnimatedSlide(
              duration: const Duration(milliseconds: 400),
              offset:
              showSubtitle ? Offset.zero : const Offset(1, 0),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: showSubtitle ? 1 : 0,
                child: OnboardingSubtitle(text: item.subtitle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}