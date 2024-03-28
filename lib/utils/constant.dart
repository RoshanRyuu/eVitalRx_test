import 'package:flutter/material.dart';

class LocalVariables {
  static const String token = "token";
}

class AppColor {
  static const Color primaryColor = Color(0xff165496);
  static const Color secondaryColor = Color(0xffED008C);
  static const Color white = Colors.white;
  static const Color transparent = Colors.transparent;
  static const Color grey = Color(0xff777777);
  static const Color lightGrey = Color(0xffCDCDCD);
  static const Color black = Colors.black;
  static const Color darkGrey = Color(0xff797979);

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
