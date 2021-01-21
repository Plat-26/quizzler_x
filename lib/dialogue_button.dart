import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'constants.dart';


class DialogueButton extends DialogButton {
  DialogueButton({@required this.dialogueButtonTitle, this.onPressed});

  final Function onPressed;
  final String dialogueButtonTitle;
  @override
  Widget build(BuildContext context) {
    return DialogButton(
      child: Text(
        dialogueButtonTitle,
        style: kDialogueButtonTextStyle,
      ),
      onPressed: onPressed,
    );
  }
}

