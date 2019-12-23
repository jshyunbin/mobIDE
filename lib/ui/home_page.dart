
import 'package:flutter/material.dart';

GestureDetector homeProject(String title, String description, Object
tapCallback) {
  return GestureDetector(
    child: Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title),
          Text(description),
          Text('date'),
        ],
      ),
    ),
    onTap: tapCallback,
  );
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.toDestination}): super(key: key);

  final Object toDestination;

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
            'adipiscing elit. Sed id aliquam erat. Curabitur rutrum nunc '
            'odio, tempor laoreet sem mollis et.', null),
        homeProject('sample 2', 'Lorem ipsum dolor sit amet, consectetur '
            'adipiscing elit. Sed id aliquam erat. Curabitur rutrum nunc '
            'odio, tempor laoreet sem mollis et.', null),
      ],
    );
  }

}