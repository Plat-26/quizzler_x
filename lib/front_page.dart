import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/services.dart';

const Color pageBackgroundColor = Color(0xff20061A);
const Color mainColor2 = Color(0xff401133);
const Color mainColor3 = Color(0xff240129);

class QuizFrontPage extends StatefulWidget {
  @override
  _QuizFrontPageState createState() => _QuizFrontPageState();
}

class _QuizFrontPageState extends State<QuizFrontPage> {

  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  final input = RegExp('[a-zA-Z]');
  String name;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        backgroundColor: pageBackgroundColor,
        appBar: AppBar(
          backgroundColor: pageBackgroundColor,
          title: Center(
            child: Text(
              'Quizzler_X',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100.0),
                  child: Center(
                    child: Text(
                      'Test your knowledge on',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    color: Colors.teal[900],
                    child: FlatButton(
                      child: Text(
                        'Laws and Rights',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/lawSecond', arguments: null);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    color: Colors.teal[900],
                    child: FlatButton(
                      child: Text(
                        'Friend',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Alert(
                            context: context,
                            title: 'Enter your friend\'s name',
                            content: Form(
                              key: _formKey,
                              child: TextFormField(
                                controller: myController,
                                decoration: InputDecoration(
                                  icon: Icon(
                                      Icons.person,
                                  ),
                                  // labelText: 'Friend\'s name',
                                ),
                                validator: (String text) {
                                  if (!input.hasMatch(text)) {
                                    return 'Enter a name';
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
                                  if (_formKey.currentState.validate()) {
                                    name = myController.text ;
                                    Navigator.pushNamed(
                                      context,
                                      '/friendQuiz',
                                      arguments: '${name[0].toUpperCase()}${name.substring(1)}',
                                    );
                                    print(name);
                                  }
                                },
                              ),
                            ]).show();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
