import 'package:flutter/material.dart';

class MyTheme {
  /*configurable colors stars*/
  static Color accent_color = Color(0xFF56667E); //Color.fromRGBO(230,46,4, 1);
  static Color gold_color = Color(0xFFCBAF87);
  static Color soft_accent_color = Color.fromRGBO(247, 189, 168, 1);
  static Color splash_screen_color = Color.fromRGBO(255, 255, 255,
      1); // Color.fromRGBO(230,46,4, 1); // if not sure , use the same color as accent color
  /*configurable colors ends*/

  /*If you are not a developer, do not change the bottom colors*/
  static Color white = Color.fromRGBO(255, 255, 255, 1);
  static Color light_grey = Color.fromRGBO(239, 239, 239, 1);
  static Color dark_grey = Color.fromRGBO(112, 112, 112, 1);
  static Color menu_bg = Color.fromRGBO(231, 222, 200, 1);
  static Color medium_grey = Color.fromRGBO(132, 132, 132, 1);
  static Color medium_grey_50 = Color.fromRGBO(132, 132, 132, .5);
  static Color grey_153 = Color.fromRGBO(153, 153, 153, 1);
  static Color font_grey = Color.fromRGBO(73, 73, 73, 1);
  static Color textfield_grey = Color.fromRGBO(209, 209, 209, 1);
  static Color golden = Color.fromRGBO(248, 181, 91, 1);
  static Color shimmer_base = Colors.grey.shade50;
  static Color shimmer_highlighted = Colors.grey.shade200;
  static Color errorBg = Color.fromRGBO(219, 147, 147, 0.9019607843137255);

  //testing shimmer
  /*static Color shimmer_base = Colors.redAccent;
  static Color shimmer_highlighted = Colors.yellow;*/

}

class Warna {
  static Color blueBaz = Color(0xff7789A4);
  static Color blueHalfBaz = Color(0xff7789A4).withOpacity(0.50);
  static Color blueQuarterBaz = Color(0xff7789A4).withOpacity(0.25);
  // static Color blueQuarterBaz = Colors.grey.shade300;
  static Color goldBaz = Color(0xffB3894D);
  static Color goldHalfBaz = Color(0xffB3894D).withOpacity(0.50);
  static Color goldQuarterBaz = Color(0xffB3894D).withOpacity(0.25);
  static Color redBaz = Color(0xffF3726C);
}
