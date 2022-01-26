import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Color light = const Color(0xFFF7F8FC);
const Color lightGrey = Color(0xFFA4A6B3);
Color active = const Color(0xFF008BCE);
const Color dark = Color(0xFF4D4D52);
Color red = const Color(0xFFD08A88);
const Color redBack = Color(0xFFF1CFCD);
Color yellow = const Color(0xffd0b379);
Color primaryColor = const Color(0xff85c498);
Color darkGreen = const Color(0xFF5EB19A);
Color blue = const Color(0xff85b4d0);
Color darkBlue = const Color(0xFF5C96B6);


TextStyle get subHeadlineStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? lightGrey : Colors.grey));
}

TextStyle get headlineStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? light : Colors.black87));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? light : Colors.black));
}

TextStyle get pageTitle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? light : lightGrey));
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[600]));
}

TextStyle get subTitleStyle16 {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[600]));
}