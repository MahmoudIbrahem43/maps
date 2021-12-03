import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget buildDrawerHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsetsDirectional.fromSTEB(70, 10, 70, 10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.blue[100],
          ),
          child: Image.asset(
            'assets/images/mahmoud.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Text('Mahmoud Ibrahem' , style: TextStyle(fontSize: 18),)
      ],
    );
  }
}
