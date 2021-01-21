import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'alert_button.dart';
import 'dialogue_button.dart';
import 'question.dart';


class ArgumentStore {
  List<bool> userAnswers;
  String friendName;
  List<Question> questions;

  ArgumentStore(this.userAnswers, this.friendName, this.questions);
}

class FriendScorePage extends StatefulWidget {
  final ArgumentStore userData;
  FriendScorePage(this.userData);

  @override
  _FriendScorePageState createState() => _FriendScorePageState(userData);
}

class _FriendScorePageState extends State<FriendScorePage> {
  ArgumentStore data;
  List<bool> userAnswers;

  String friendName;

  List<Question> questions;

  _FriendScorePageState(ArgumentStore userData) {
    userAnswers = userData.userAnswers;

    friendName = userData.friendName;

    questions = userData.questions;
  }

  static int userRating = 0;
  static int displayCount = 0;

  AlertForm friendScoreForm;

  @override
  initState() {
    super.initState();
    display();
  }

  @override
  void dispose() {
    friendScoreForm.myController.dispose();
    super.dispose();
  }

  String showQuestion() {
    return questions[displayCount].questionText;
  }

  bool showAnswer() {
    return userAnswers[displayCount];
  }

  static List<Container> show = [];

  void display() {
    for (int i = 0; i < questions.length - 1; i++) {
      show.add(
        Container(
          height: 50.0,
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              showQuestion() + '\n Your answer: ' + showAnswer().toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
      displayCount++;
    }
    displayCount = 0;
    show.add(
      Container(
        height: 50,
        child: FlatButton(
          child: Text(
            'CONTINUE',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Alert(
                context: context,
                title: 'How many stars did you get?',
                content: friendScoreForm = AlertForm(
                  iconType: Icons.star,
                  errorText: 'Please enter a number from 0 - 5',
                  inputRegex: RegExp('[0-5]'),
                  ),
                buttons: [
                  DialogueButton(
                    dialogueButtonTitle: 'Continue',
                    onPressed: () {
                      show.removeRange(0, show.length);
                      if (friendScoreForm.formKey.currentState.validate()) {
                        userRating = int.parse(friendScoreForm.myController.text);
                        print(userRating);
                        Navigator.pushNamed(
                          context,
                          '/displayRating',
                          arguments: userRating,
                        );
                      }
                    },
                  ),
                ]).show();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff20061A),
      appBar: AppBar(
        backgroundColor: Color(0xff20061A),
        title: Center(
          child: Text('Let $friendName rate you!'),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: show,
        ),
      ),
    );
  }
}
