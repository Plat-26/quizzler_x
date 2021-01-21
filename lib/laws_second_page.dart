import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzler_x/constants.dart';

class LawsSecondPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        // backgroundColor: purpleShade2,
        backgroundColor: Color(0xff34975),
        body: SafeArea(
          child: FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, '/lawQuiz');
            },
            child: Container(
              margin: EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  'So you think you know your civil rights...',
                  textAlign: TextAlign.center,
                  style: kLawSecondPageTextStyle,
                ),
              ),
            ),
          ),
        ),
    );
  }
}