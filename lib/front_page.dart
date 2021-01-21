import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/services.dart';
import 'alert_button.dart';
import 'constants.dart';
import 'dialogue_button.dart';
import 'rectangle_button.dart';

class QuizFrontPage extends StatefulWidget {
  @override
  _QuizFrontPageState createState() => _QuizFrontPageState();
}

class _QuizFrontPageState extends State<QuizFrontPage> {
  AlertForm friendForm;
  String name;

  @override
  void dispose() {
    friendForm.myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: kFrontPageBackground,
      appBar: AppBar(
        backgroundColor: kFrontPageBackground,
        title: Center(
          child: Text(
            'Quizzler_X',
            style: kAppBarTextStyle,
          ),
        ),
      ),
      body: SafeArea(
        // child: SingleChildScrollView (
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Test your knowledge on',
                  textAlign: TextAlign.center,
                  style: kFrontPageTextStyle,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              flex: -2,
              child: RectangleButton(
                quizTypeText: 'Laws and Rights',
                onPressed: () {
                  Navigator.pushNamed(context, '/lawSecond', arguments: null);
                },
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Expanded(
              flex: -2,
              child: RectangleButton(
                quizTypeText: 'Friend',
                onPressed: () {
                  Alert(
                      context: context,
                      title: 'Enter your friend\'s name',
                      content: friendForm = AlertForm(
                        inputRegex: RegExp('[a-zA-Z]'),
                        errorText: 'Enter a name',
                        iconType: Icons.person,
                      ),
                      buttons: [
                        DialogueButton(
                          dialogueButtonTitle: 'Continue',
                          onPressed: () {
                            if (friendForm.formKey.currentState.validate()) {
                              name = friendForm.myController.text;
                              Navigator.pushNamed(
                                context,
                                '/friendQuiz',
                                arguments:
                                '${name[0].toUpperCase()}${name.substring(1)}',
                              );
                              print(name);
                            }
                          },
                        ),
                      ]).show();
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(),
            ),
          ],
        ),
      ),
      // ),
    );
  }
}



