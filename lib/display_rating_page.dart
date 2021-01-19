import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const pageBackgroundColor = Color(0xff20061A);
const List<String> _message = [
  'Wow no stars for you',
  'You should take this test again',
  'Knows nothing but might be useful',
  'Nicely done',
  'You deserve cupcakes!',
  'WORLD STAR!!',
];

class DisplayRating extends StatefulWidget {

  final int numOfStars;
  DisplayRating(this.numOfStars);

  @override
  _DisplayRatingState createState() => _DisplayRatingState(numOfStars);
}

class _DisplayRatingState extends State<DisplayRating> {

   final int numOfStars;
  _DisplayRatingState(this.numOfStars);
  List<Icon> _totalStars = [];


  @override
  void initState() {
    displayStars();
    super.initState();
  }

  void displayStars() {
    if (numOfStars == 0) {
      return;
    }
    for (int i = 0; i < numOfStars; i++) {
      _totalStars.add(
        Icon(
          Icons.star,
          size: 35.0,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackgroundColor,
      appBar: AppBar(
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
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 9,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _totalStars,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        _message[numOfStars],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          Expanded(
            child: Container(
              // height: 50,
              width: double.infinity,
              child: FlatButton(
                child: Text(
                  'EXIT',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).popUntil(ModalRoute.withName('/'));
                },
              ),
            ),
          ),
        ],
      )),
    );
  }
}
