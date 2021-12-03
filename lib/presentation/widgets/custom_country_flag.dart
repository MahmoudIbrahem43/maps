import 'package:flutter/material.dart';

class CustomCountryFlage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      generateCountryFlage() + '  +20',
      style: TextStyle(fontSize: 18),
    );
  }

  String generateCountryFlage() {
    String countryCode = 'eg';
    String flage = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
            (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

    return flage + ' ';
  }
}
