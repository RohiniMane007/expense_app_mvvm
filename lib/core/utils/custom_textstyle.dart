import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle titleTextStyle({double? fontsize, Color? color}) {
    return const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)
        .copyWith(fontSize: fontsize, color: color);
  }

  static TextStyle subTextStyle({FontStyle? fontstyle}) {
    return const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontStyle: FontStyle.italic)
        .copyWith(fontStyle: fontstyle);
  }
}
