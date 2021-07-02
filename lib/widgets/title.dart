import 'package:flutter/material.dart';

Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        "The",
        style: TextStyle(color: Colors.red),
      ),
      Text(
        "Wallpaper",
        style: TextStyle(
          color: Colors.black,
        ),
      )
    ],
  );
}
