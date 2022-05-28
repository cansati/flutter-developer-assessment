import 'package:flutter/material.dart';

class WidgetHelper {
  Widget getLoginButtonDesign(BuildContext context, double buttonHeight,
      double buttonWidth, String buttonText, double textFontSize) {
    return Container(
      width: buttonWidth,
      height: buttonHeight,
      child: Center(
          child: Text(buttonText,
              style: TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: textFontSize))),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(236, 60, 3, 1),
                Color.fromRGBO(234, 60, 3, 1),
                Color.fromRGBO(216, 78, 16, 1),
              ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.16),
              offset: Offset(0, 5),
              blurRadius: 10.0,
            )
          ],
          borderRadius: BorderRadius.circular(5.0)),
    );
  }
}
