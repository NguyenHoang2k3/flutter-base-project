import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../gen/fonts.gen.dart';
import 'colors.dart';

abstract class AppStyles {
  static const h1 = TextStyle(
    fontSize: 20,
      height: 30 / 20,
    fontWeight: FontWeight.w400,
    color: AppColors.grayScale,
    fontFamily: 'Poppins'
  );
  static const h2 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 22 / 14,
      color: AppColors.grayScale,
      fontFamily: 'Poppins'
  );
  static const h3 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 22 / 16,
    color: AppColors.black,
    fontFamily: 'Poppins',
  );
  static const primary = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13,
    height: 19.5 / 13,
    color: AppColors.grayScale,
    fontFamily: 'Poppins',
  );
  static const medium = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 11,
    height: 22 / 11,
    color: AppColors.grayScalee,
    fontFamily: 'Poppins',
  );
  static const small = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 22 / 16,
    fontFamily: 'Poppins',
    color: AppColors.grayScale
  );
  static const highlightsMedium = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 22 / 16,
    color: AppColors.black,
    fontFamily: 'Poppins',
  );
  static const highlightsBold = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 24,
    height: 36 / 24,
    color: AppColors.black,
    fontFamily: 'Poppins',
  );
  static const button = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 13,
    height: 18 / 13,
    fontFamily: FontFamily.googleSans,
  );
  static const title = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 13,
      height: 19.5 / 13,
      color: AppColors.grayScale,
      fontFamily: 'Poppins'
  );
  static const header = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    height: 28 / 18,
    fontFamily: FontFamily.googleSans,
  );
  static const bottomNavigation = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 11,
    height: 16 / 11,
    fontFamily: FontFamily.googleSans,
  );

  //text
  static const textSmall = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 21 / 14,
    fontFamily: FontFamily.poppins,
  );
  static const textXSmall = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 13,
    height: 19.5 / 13,
    fontFamily: FontFamily.poppins,
  );
  static const textMedium = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 24 / 16,
    fontFamily: FontFamily.poppins,
  );
  static const textLarge = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 20,
    height: 30 / 20,
    fontFamily: FontFamily.poppins,
  );

  //display
  static const textDisplaySmall = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 24,
    height: 36 / 24,
    fontFamily: FontFamily.poppins,
  );
  static const textDisplayMedium = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 32,
    height: 48 / 32,
    fontFamily: FontFamily.poppins,
  );
  static const textDisplayLarge = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 48,
    height: 72 / 48,
    fontFamily: FontFamily.poppins,
  );  static const textDisplaySmallBold = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 24,
    height: 36 / 24,
    fontFamily: FontFamily.poppins,
  );
  static const textDisplayMediumBold = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 32,
    height: 48 / 32,
    fontFamily: FontFamily.poppins,
  );
  static const textDisplayLargeBold = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 48,
    height: 72 / 48,
    fontFamily: FontFamily.poppins,
  );

  //link
  static const textSmallLink = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 21 / 14,
    fontFamily: FontFamily.poppins,
  );
  static const textXSmallLink = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13,
    height: 19.5 / 13,
    fontFamily: FontFamily.poppins,
  );
  static const textMediumLink = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 24 / 16,
    fontFamily: FontFamily.poppins,
  );
  static const textLargeLink = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 30 / 20,
    fontFamily: FontFamily.poppins,
  );
}