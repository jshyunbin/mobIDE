import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TerminalPage extends StatefulWidget {
  @override
  _TerminalPageState createState() => _TerminalPageState();
}

class _TerminalPageState extends State<TerminalPage> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.0), topLeft: Radius.circular(12.0))),
      child: Center(
        child: Text('Terminal Here'),
      ),
    );
  }
}
