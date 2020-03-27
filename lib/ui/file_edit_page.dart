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
import 'package:mobide/ui/components/editor_panel.dart';
import 'package:mobide/ui/components/editor_tab.dart';
import 'package:mobide/ui/theme/style.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FileEditPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  final BorderRadiusGeometry panelRadius = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

  final PanelController _pc = new PanelController();

  // TODO: erase this => implemented on a lower level
  final SSHFile file = SSHFile("hello.txt", FileType.txt, "a", "a", "a");

  Widget _body(context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Editor',
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
      body: EditorTab(),
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
        panel: EditorPanel(),
        body: _body(context),
      ),
    );
  }
}
