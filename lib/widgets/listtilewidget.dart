import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget aboutListTile({
  String title,
  IconData icon,
  String subtitle,
  Function onTap,
  Function onLongPress,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    child: Column(
      children: <Widget>[
        Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                mainAxisSize: MainAxisSize.min,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  icon != null ? Icon(icon, size: 18.0) : Container(),
                  SizedBox(width: 8.0),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              subtitle: subtitle != null
                  ? Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                      ),
                    )
                  : null,
            ),
            onTap: onTap,
            onLongPress: onLongPress,
          ),
        ),
      ],
    ),
  );
}
