import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void SuccessAlert(BuildContext context, String name) {
  Alert(
    context: context,
    type: AlertType.success,
    title: "Success",
    desc: "$name \n Your Data has been saved",
    buttons: [
      DialogButton(
        child: Text(
          "Close",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}

void ErrorAlert(BuildContext context, String title, String Message) {
  Alert(
    context: context,
    type: AlertType.error,
    title: title,
    desc: Message,
    buttons: [
      DialogButton(
        child: Text(
          "Close",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}
