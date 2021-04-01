import 'package:flutter/material.dart';

final String message = "The Wallpaper Powered by Pexel";
final String url = "";
final String gitHubUrl = "https://github.com/4eug";
// API key from https://www.pexels.com/api/
//

const baseHeight = 640.0;

double kScreenAwareSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / baseHeight;
}
