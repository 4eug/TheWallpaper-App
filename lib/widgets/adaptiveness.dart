import 'package:flutter/material.dart';
import 'package:the_wallpapers/const.dart';

class Adaptiveness extends StatelessWidget {
  final String title, selectText, cancelText;
  final Widget child;
  final double maxWidth;
  final bool hasSelectButton, hasCancelButton, hasButtonBar;
  final Function onSelectPressed, onCancelPressed;

  const Adaptiveness({
    this.title,
    this.child,
    this.onSelectPressed,
    this.onCancelPressed,
    this.selectText,
    this.cancelText,
    this.maxWidth,
    this.hasSelectButton = true,
    this.hasCancelButton = true,
    this.hasButtonBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: maxWidth ?? 500.0,
                  maxHeight: MediaQuery.of(context).size.height,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: ListTile(
                        contentPadding: EdgeInsets.only(top: 8.0, left: 24.0),
                        title: Text(
                          title,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3),
                        ),
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height - 200.0,
                      ),
                      child: child,
                    ),
                    hasButtonBar
                        ? Flexible(
                            child: ButtonBar(
                              alignment: MainAxisAlignment.end,
                              buttonTextTheme: ButtonTextTheme.normal,
                              children: <Widget>[
                                hasCancelButton
                                    ? TextButton(
                                        child: Text(cancelText ?? 'Cancel',
                                            style: titleTextStyle),
                                        onPressed: () => onCancelPressed == null
                                            ? Navigator.pop(context)
                                            : onCancelPressed(),
                                      )
                                    : SizedBox(),
                                hasSelectButton
                                    ? TextButton(
                                        child: Text(selectText ?? 'Select',
                                            style: titleTextStyle),
                                        onPressed: () => onSelectPressed == null
                                            ? Navigator.pop(context)
                                            : onSelectPressed(),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
