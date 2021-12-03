import 'package:flutter/material.dart';



void showProgressIndicator(BuildContext context) {
  AlertDialog alertDialog = AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
    ),
  );
  showDialog(
      barrierDismissible: false,
      barrierColor: Colors.white.withOpacity(0),
      context: context,
      builder: (context) {
        return alertDialog;
      });
}
