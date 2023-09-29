import 'package:flutter/material.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';

class CustomText extends StatelessWidget {
  final String title;
  final FontWeight? fontWeight;
  final Color? color;
  final String? fontFamily;
  final double? fontSize;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign? textAlign;
  final double? wordSpacing;
  final double? letterSpacing;
  final double? height;
  final Color? backgroundColor;
  const CustomText(
    this.title, {
    this.fontWeight = FontWeight.w600,
    this.color,
    this.fontFamily,
    this.fontSize,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.wordSpacing,
    this.letterSpacing,
    this.height,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: fontWeight,
        color: color ?? AppColors.apptheme,
        fontSize: fontSize,
        fontFamily: fontFamily,
        wordSpacing: wordSpacing,
        letterSpacing: letterSpacing,
        backgroundColor: backgroundColor,
        height: height,
      ),
      textScaleFactor: 1,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
