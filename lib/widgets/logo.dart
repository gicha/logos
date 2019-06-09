import 'package:flutter/material.dart';
import 'package:logos/styles.dart';

class LogoText extends StatelessWidget {
  final double widthFactor;
  final double heightFactor;
  LogoText([this.widthFactor = 0.8, this.heightFactor = 0.07]);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * widthFactor,
      height: size.height * heightFactor,
      child: FittedBox(
        alignment: Alignment.center,
        child: Text(
          "Logos",
          textAlign: TextAlign.center,
          style: genTextStyle(blueColor, 26, boldWeight),
        ),
      ),
    );
  }
}
