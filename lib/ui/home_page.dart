
import 'package:flutter/material.dart';

Card homeProject(String title, String description) {
  return Card(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(title),
        Text(description),
      ],
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State {

  void _onUpdate() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      //TODO: replace the list.
      children: <Widget>[
        homeProject('sample 1', 'Lorem ipsum dolor sit amet, consectetur '
            'adipiscing elit. Sed id aliquam erat. Curabitur rutrum nunc odio, tempor laoreet sem mollis et.'),
        homeProject('sample 2', 'Lorem ipsum dolor sit amet, consectetur '
            'adipiscing elit. Sed id aliquam erat. Curabitur rutrum nunc odio, tempor laoreet sem mollis et.'),
      ],
    );
  }

}