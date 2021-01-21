import 'dart:core';
import 'package:quizzler_x/quiz_page.dart';

import 'question.dart';

const List<String> _potentialQuestions = [
  '0 would rather sleep elsewhere than deal with a cockroach',
  'One of 0\'s favourite thing to do is sleep',
  '0 has not seen any episode of Game of Thrones',
  '0 can barely cook to save a life',
  '0\'s favourite weekends are those spent outdoors',
  'Right now 0 would choose a music concert over a cinema binge',
  'In high school 0 was popular for breaking rules',
  '0 would choose tea over coffee',
  '0 drinks coffee without milk',
  '0 is more likely to survive trekking than hustling for a bus',
  '0 sleeps before 1am',
  '0 consumes an inordinate amount of pastries',
  '0 has the strangest pet peeves',
  '0 would be voting in the 2023 elections',
  '0 attends a school featured in a Netflix movie ',
];

class QuizAppBrain {

  int _questionNumber = 0;
  int choice;
  static String name;
  int totalQuestion = 10;

  List<Question> _questionBank;

  QuizAppBrain(QuizType quizType, String friendName) {

    if (quizType == QuizType.Rights) {
      _questionBank = _rightsQuestionBank;
      this.choice = 0;
    } else if (quizType == QuizType.Friend)  {
      _questionBank = friendQuestionBank;
      name = friendName;
      this.choice = 1;
    }
  }

  String friend = name;

  List<Question> _rightsQuestionBank = [
    Question('Unlawful detention is a case in which a person has been arrested without a clear evidence of offence.', true),
    Question('A citizen of Nigeria can propose a bill to the house of senate if the bill is presented by a sitting member.', true),
    Question('A person who has been unlawfully detained does not have to wait for 24hrs before being able to demand legal counsel.', false),
    Question('The National Assembly does not have the power to enact international agreements into law.', false),
    Question('The constitution of the Federal Republic of Nigeria does not make provisions for its alteration.', false),
    Question('A person whose life and property has been threatened and who is not in a position to pay for damages or afford a lawyer has the right to legal aid.', true),
    Question(
        'A person above the age of 21 is regarded as an adult in Nigeria.',
        true),
    Question(
        'A person above the age of 18 is regarded as an adult in Nigeria',
        false),
    Question(
        'A nation can exist in solitude without cordial relations with other nations.',
        false),
    Question(
        'English law is one of the most veritable source of law in Nigeria because of its colonial heritage.',
        true),
    Question('The criminal code of conduct of Nigeria classifies indecent assault of women and girls as a \'misdemeanour\' (a lesser offence) unlike where the same act if committed on a male person is a felony', true),
    Question(
        'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
        true),
    Question(
        'A section of the penal code makes it unlawful for a man to beat his wife for the purpose of correcting her',
        false),
  ];


  void createQuiz() {
    for (int i = 0; i < _potentialQuestions.length; i++) {
      String question = _potentialQuestions[i].replaceFirst('0', name);
      friendQuestionBank.add(Question.forFriends(question));
    }
  }

  List<Question> friendQuestionBank = [

  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  bool getAnswer() {
    return _questionBank[_questionNumber].questionAnswers;
  }

  String getQuestionText() {
    return  _questionBank[_questionNumber].questionText;
  }

  String getFriendQuestion(int number) {
    return friendQuestionBank[number].questionText;
  }

  bool isFinished() {
    if (_questionNumber == _questionBank.length - 1) {
      return true;
    }
    return false;
  }

  void reset() {
    _questionNumber = 0;
  }

}