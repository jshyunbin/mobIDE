//Copyright 2020 Joshua Hyunbin Lee, Jaeyong Sung
//
//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at
//
//http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobide/ui/components/sftp.dart';
import 'package:mobide/ui/components/terminal.dart';
import 'package:mobide/ui/theme/style.dart';

class EditorPanel extends StatefulWidget {
  EditorPanel({Key key}) : super(key: key);

  @override
  _EditorPanelState createState() => _EditorPanelState();
}

class _EditorPanelState extends State<EditorPanel> {
  int tabValue = 1;

  List<Widget> title = [
    Text(
      'Terminal',
      style: Type.header4.apply(color: Colors.black),
    ),
    Text(
      'SFTP',
      style: Type.header4.apply(color: Colors.black),
    ),
  ];

  List<Widget> content = [
    TerminalPage(),
    SFTPPage(),
  ];

  void _onTap(int newValue) {
    setState(() {
      tabValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 35,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: title[tabValue],
              ),
              CupertinoSlidingSegmentedControl(
                children: {
                  0: Text('Terminal'),
                  1: Text('SFTP'),
                },
                groupValue: tabValue,
                onValueChanged: (newValue) => _onTap(newValue),
              )
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Expanded(
            child: content[tabValue],
          ),
        ],
      ),
    );
  }
}
