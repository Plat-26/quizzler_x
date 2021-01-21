import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dialogue_button.dart';
import 'friend_score_page.dart';
import 'quiz_App_Brain.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class QuizApp extends StatefulWidget {
  final QuizType quizType;
  final String name;
  QuizApp(this.quizType, this.name);

  _QuizAppState createState() => _QuizAppState(quizType, name);
}

class _QuizAppState extends State<QuizApp> {
  static AudioCache musicCache;
  static AudioPlayer instance;

  static void playLoop() async {
    musicCache = AudioCache();
    instance = await musicCache.loop('sound.wav');
  }

  @override
  void initState() {
    super.initState();
    playLoop();
  }

  @override
  void dispose() {
    instance.dispose();
    super.dispose();
  }
  static QuizAppBrain quizBrain;
  static String userFriend;

  _QuizAppState(QuizType quizType, String name) {
    if (quizType == QuizType.Rights) {
      quizBrain = QuizAppBrain(QuizType.Rights, name);
    } else if (quizType == QuizType.Friend) {
      quizBrain = QuizAppBrain(QuizType.Friend, name);
      quizBrain.createQuiz();
      userFriend = name;
    }
  }


  List<Icon> scoreTracker = [];

  int userCorrectAnswers = 0;
  int totalQuestions = 0;

  List<bool> answersForFriend = [];

  void validateAnswerFriend(bool userAnswer) {
    if (quizBrain.isFinished() == true) {
      instance.stop();
      instance.dispose();
      Alert(
        context: context,
        title: 'Quizzler_x',
        desc: 'The End',
        buttons: [
          DialogueButton(
            dialogueButtonTitle: 'Continue',
            onPressed: () {
              Navigator.pushNamed(context, '/friendQuizScores',
                  arguments: ArgumentStore(
                      answersForFriend, userFriend, quizBrain.friendQuestionBank));
            },
          ),
        ],
      ).show();

    } else {
      answersForFriend.add(userAnswer);
    }
  }

  void validateAnswerLaw(bool userAnswer) {
    totalQuestions++;
    if (quizBrain.isFinished() == true) {
      instance.stop();
      instance.dispose();
      Alert(
        context: context,
        title: 'Quizzler_x',
        desc: 'You got $userCorrectAnswers out of $totalQuestions',
        buttons: [
          DialogueButton(
            dialogueButtonTitle: 'Restart',
            onPressed: () {
              quizBrain.reset();
              scoreTracker.removeRange(0, scoreTracker.length);
              userCorrectAnswers = 0;
              Navigator.of(context).popUntil(ModalRoute.withName('/'));
            },
          ),
        ],
      ).show();
      // quizBrain.reset();
      // scoreTracker.removeRange(0, scoreTracker.length);
      // userCorrectAnswers = 0;
    } else {
      if (quizBrain.getAnswer() == userAnswer) {
        userCorrectAnswers++;
        scoreTracker.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        scoreTracker.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // type = quizType;
    // QuizAppBrain quiz = QuizAppBrain(quizType);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  quizBrain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ),
            )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                setState(() {
                  if (quizBrain.choice == 0) {
                    validateAnswerLaw(true);
                  } else if (quizBrain.choice == 1) {
                    validateAnswerFriend(true);
                  }
                  quizBrain.nextQuestion();
                });
                //user pressed true
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  if (quizBrain.choice == 0) {
                    validateAnswerLaw(false);
                  } else if (quizBrain.choice == 1) {
                    validateAnswerFriend(false);
                  }
                  quizBrain.nextQuestion();
                });
                //user clicked false
              },
            ),
          ),
        ),
        Row(
          children: scoreTracker,
        ),
      ],
    );
  }
}

enum QuizType {
  Rights,
  Friend
}

class QuizAppUI extends StatelessWidget {
  final QuizType quizType;
  final String name;

  QuizAppUI(this.quizType, this.name);

  final Color purpleShade2 = Color(0xff34975);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade900,
      backgroundColor: Colors.black12,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizApp(quizType, name),
        ),
      ),
    );
  }
}
