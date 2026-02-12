import 'package:flutter/material.dart';
import 'package:flutter_practical_task/core/app_colors.dart';
import 'package:flutter_practical_task/utils/constants/fonts/fonts_weight.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  String text;
  Color? color;
  Color? decorationColor;
  FontWeight? fontWeight;
  TextDecoration? decoration;
  double fontSize;
  int? maxLines;
  double? minFontSize;
  double? maxFontSize;
  TextAlign? textAlign;
  TextOverflow? overflow;

  CustomText(
      {required this.text,
      this.color,
      this.decorationColor,
      this.fontWeight,
      this.decoration,
      required this.fontSize,
      this.maxLines,
      this.minFontSize,
      this.maxFontSize,
      this.textAlign,
      this.overflow,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          decoration: decoration,
          decorationColor: decorationColor,
          fontWeight: fontWeight ?? regular,
          color: color ?? black000000Color,
          fontSize: fontSize,
        ),
      ),
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
