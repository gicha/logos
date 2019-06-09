import 'package:flutter/material.dart';
import 'package:logos/styles.dart';

class Badge extends StatelessWidget {
  final String text;
  Badge(this.text);
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Container(
        height: 35,
        margin: EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          color: violetColor,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(text, style: genTextStyle(whiteColor, normalSize, normalWeight))
            ]),
      )
    ]);
  }
}
