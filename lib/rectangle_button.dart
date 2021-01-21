import 'package:flutter/material.dart';
import 'constants.dart';

class RectangleButton extends StatelessWidget {
  RectangleButton({@required this.quizTypeText, this.onPressed});

  final Function onPressed;
  final String quizTypeText;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 50.0),
      color: Colors.teal[900],
      child: FlatButton(
        onPressed: onPressed,
        child: Text(
          quizTypeText,
          style: kRectangleButtonTextStyle,
        ),
      ),
    );
  }
}
