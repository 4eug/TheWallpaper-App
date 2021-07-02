import 'package:flutter/material.dart';

final String message = "Check this Wallpaper App:";

const titleTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  letterSpacing: 0.3,
);

Color brightnessAwareColor(BuildContext context,
    {Color lightColor, Color darkColor}) {
  return themeBrightness(context) == Brightness.light ? lightColor : darkColor;
}

Brightness themeBrightness(BuildContext context) {
  return Theme.of(context).brightness;
}
