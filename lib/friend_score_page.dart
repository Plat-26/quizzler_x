import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzler_x/question.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class StoreArguments {
  List<bool> userAnswers;
  String friendName;
  List<Question> questions;

  StoreArguments(this.userAnswers, this.friendName, this.questions);
}

class ShowScores extends StatefulWidget {
  final StoreArguments userData;
  ShowScores(this.userData);

  @override
  _ShowScoresState createState() => _ShowScoresState(userData);
}

class _ShowScoresState extends State<ShowScores> {
  StoreArguments data;
  List<bool> userAnswers;

  String friendName;

  List<Question> questions;

  _ShowScoresState(StoreArguments userData) {
    userAnswers = userData.userAnswers;

    friendName = userData.friendName;

    questions = userData.questions;
  }

  final _formKey = GlobalKey<FormState>();

  final myController = TextEditingController();

  final input = RegExp('[0-5]');

  static int userRating = 0;

  static int displayCount = 0;

  @override
  initState() {
    super.initState();
    display();
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
                content: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: myController,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.star,
                        color: Colors.black,
                      ),
                      // labelText: 'Your rating',
                    ),
                    validator: (String text) {
                      if (!input.hasMatch(text)) {
                        return 'Please enter a number from 0 - 5';
                      }
                      return null;
                    },
                  ),
                ),
                buttons: [
                  DialogButton(
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      show.removeRange(0, show.length);
                      if (_formKey.currentState.validate()) {
                        userRating = int.parse(myController.text);
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
