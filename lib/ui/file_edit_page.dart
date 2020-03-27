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
import 'package:flutter/material.dart';
import 'package:mobide/backend/file_system.dart';
import 'package:mobide/ui/terminal.dart';
import 'package:mobide/ui/text_editor.dart';
import 'package:mobide/ui/theme/style.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FileEditPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  final BorderRadiusGeometry panelRadius = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

  final PanelController _pc = new PanelController();

  // TODO: make final
  SSHFile file;

  FileEditPage({this.file}) {
    // TODO: erase test code below
    if (this.file == null) {
      this.file = SSHFile("hello.txt", FileType.txt, "a", "a", "a");
    }
  }

  Widget _panel() {
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
                child: Text(
                  'Terminal',
                  style: Type.header4.apply(color: Colors.black),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Expanded(
            child: TerminalPage(),
          ),
        ],
      ),
    );
  }

  Widget _body(context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          this.file.name,
          style: Type.header4.apply(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.attach_money, color: Colors.green),
            onPressed: _pc.open,
          ),
        ],
      ),
      body: TextEditor.fromFile(file: this.file),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SlidingUpPanel(
        backdropEnabled: true,
        borderRadius: panelRadius,
        controller: _pc,
        minHeight: 0,
        maxHeight: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top,
        panel: _panel(),
        body: _body(context),
      ),
    );
  }
}
