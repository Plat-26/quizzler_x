import 'package:flutter/material.dart';

class AlertForm extends StatelessWidget {

  AlertForm({this.inputRegex, this.errorText, this.iconType});

  final formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  final inputRegex;
  final errorText;
  final IconData iconType;


  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        controller: myController,
        decoration: InputDecoration(
          icon: Icon(
            iconType,
          ),
          // labelText: 'Friend\'s name',
        ),
        validator: (String text) {
          if (!inputRegex.hasMatch(text)) {
            return errorText;
          }
          return null;
        },
      ),
    );
  }
}


