import 'package:flutter/material.dart';

class CustomElevationButton extends StatelessWidget {
  String? text;
  VoidCallback? onTap;
  CustomElevationButton({this.text, this.onTap});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('${text}'),
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: onTap,
    );
  }
}
