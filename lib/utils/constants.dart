import 'package:flutter/material.dart';

class OnboardItem {
  final String title;
  final String subtitle;
  final Color color;

  OnboardItem({
    required this.title,
    required this.subtitle,
    required this.color,
  });
}

final List<OnboardItem> onboardData = [
  OnboardItem(
    title: "How much\nof my earnings\ndo I get to keep?",
    subtitle: "100%.\nWe charge zero\ncommission on\nyour sales.",
    color: Colors.green,
  ),

  OnboardItem(
    title: "How do I minimize\nreturns and losses?",
    subtitle: "With us,\nyou get fewer\nreturns and\nmore profit.",
    color: Colors.red,
  ),

  OnboardItem(
    title: "What if most of my\nsales happen offline?",
    subtitle: "No worries\noffline exposure is\npart of the plan.",
    color: Colors.orange,
  ),

  OnboardItem(
    title: "Will I get paid\non time,\nand is it safe?",
    subtitle: "Always.\nPayments are\nsecure and\non-time,\nevery time.",
    color: Colors.blue,
  ),

  OnboardItem(
    title: "Can I reach more\ncustomers beyond\nmy area?",
    subtitle: "Yes!\nWe deliver to\n20,000+ pin codes\nacross India.",
    color: Colors.purple,
  ),


  OnboardItem(
    title: "When do I get\npaid?",
    subtitle: "Every week.\nDirectly to\nyour bank.",
    color: Colors.teal,
  ),

  OnboardItem(
    title: "Ready to\nstart?",
    subtitle: "yes,\nCreate account\nand begin.",
    color: Colors.deepPurple,
  ),
];
