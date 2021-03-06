import 'package:flutter/material.dart';
import 'package:mobide/ui/theme/style.dart';

class ProcessCard extends StatefulWidget {
  ProcessCard(this.name, this.commands, this.onStart);

  final String name;
  final List<String> commands;
  final bool onStart;

  @override
  _ProcessCardState createState() => _ProcessCardState();
}

class _ProcessCardState extends State<ProcessCard> {
  static const int COMPLETED = 0;
  static const int ON_PROGRESS = 1;
  static const int ON_ERROR = 2;

  int status = 1;

  void _onTriggered() {
    setState(() {});
  }

  void _onOpen() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.black54,
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.name,
                    style: Type.header5.apply(color: Colors.white),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_up,
                      color: Colors.white,
                    ),
                    onPressed: _onOpen,
                    iconSize: 30.0,
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 40,
                  ),
                  SizedBox(width: 10.0),
                  Text('Connected',
                      style: Type.header6.apply(color: Colors.white))
                ],
              ),
            ],
          ),
        ),
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: _onTriggered,
    );
  }
}

Widget addProcessCard() {
  void _onTap() {

  }

  return InkWell(
    child: DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.transparent,
          border: Border.all(
            width: 3,
            color: Colors.lightBlue,
          )
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.add_circle,
              color: Colors.lightBlue,
              size: 40,
            ),
            SizedBox(height: 20.0),
            Text('Add Action', style: Type.header6),
          ],
        ),
      ),
    ),
    splashColor: Colors.grey,
    highlightColor: Colors.transparent,
    onTap: _onTap,
  );
}
