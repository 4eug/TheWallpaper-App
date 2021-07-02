import 'package:flutter/material.dart';

///Get API key from https://www.pexels.com/api/
final String apiKey =
    "563492ad6f91700001000001bcf635e158bb4fe9adbf7100cfb75cae";
final String editorChoiceEndPoint =
    "https://api.pexels.com/v1/search?query=wallpaper";
final String perPageLimit = "&per_page=30";
final String searchEndPoint = "https://api.pexels.com/v1/search?query=";
final String message = "Check out this awesome wallpaper app:";
final String url = "";
final String gitHubUrl = "";

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
