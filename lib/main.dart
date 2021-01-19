import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzler_x/friend_score_page.dart';
import 'display_rating_page.dart';
import 'quiz_page.dart';
import 'front_page.dart';
import 'laws_second_page.dart';
import 'package:flutter/services.dart';



// TODO: Add project to gitHub repo
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xff20061A),
        ),
        //TODO: Add an app logo to replace the flutter logo
        initialRoute: '/',
        routes: {
          '/': (context) => QuizFrontPage(),
          '/lawSecond': (context) => LawsSecondPage(),
          '/lawQuiz': (context) =>
              QuizAppUI(QuizType.Rights, ModalRoute.of(context).settings.arguments),
          '/friendQuiz': (context) =>
              QuizAppUI(QuizType.Friend, ModalRoute.of(context).settings.arguments),
          '/friendQuizScores': (context) => ShowScores(ModalRoute.of(context).settings.arguments),
          '/displayRating': (context) =>
              DisplayRating(ModalRoute.of(context).settings.arguments),
          //TODO: Collate and update quiz for the civil rights question bank
        },
      ),
    );
  });
}

//For civil rights quiz
//change Ui to put quetsions on a white container ??
//put in actual questions
