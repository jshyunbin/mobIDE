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
import 'package:mobide/ui/text_editor.dart';
import 'package:mobide/ui/theme/style.dart';

class EditorTab extends StatefulWidget {
  EditorTab({Key key}) : super(key: key);

  @override
  _EditorTabState createState() => _EditorTabState();
}

class _EditorTabState extends State<EditorTab> {
  int selectedInd = 0;
  static SSHFile file = SSHFile("hello.txt", FileType.txt, "a", "a", "a");
  static SSHFile fileA = SSHFile("hello-a.txt", FileType.txt, "a", "a", "a");
  static SSHFile fileB = SSHFile("hello-b.txt", FileType.txt, "a", "a", "a");

  List<TextEditor> textEditors = [
    TextEditor.fromFile(file: file),
    TextEditor.fromFile(file: fileA),
    TextEditor.fromFile(file: fileB),
  ];

  List<String> tabs = ['hello.txt', 'main.cpp', 'fuck'];

  void _closeTab(index) {
    setState(() {
      if (selectedInd >= index && selectedInd != 0) selectedInd--;
      textEditors.removeAt(index);
      tabs.removeAt(index);
    });
  }

  void _onTap(index) {
    setState(() {
      selectedInd = index;
    });
  }

  Widget _noTab() {
    return Center(
      child: Text('No files selected!\nSelect Files in the SFTP panel.'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return tabs.length == 0
        ? _noTab()
        : Column(
            children: <Widget>[
              SizedBox(
                height: 35,
                child: ListView.builder(
                  itemBuilder: (_, index) => DecoratedBox(
                    decoration: BoxDecoration(
                        color: (selectedInd == index)
                            ? Colors.black38
                            : Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12.0))),
                    child: InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              tabs[index],
                              style: (selectedInd == index)
                                  ? Type.body1.apply(color: Colors.white)
                                  : Type.body1,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.close,
                              ),
                              iconSize: 18.0,
                              onPressed: () => _closeTab(index),
                            )
                          ],
                        ),
                      ),
                      onTap: () => _onTap(index),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                  ),
                  itemCount: tabs.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(
                child: textEditors[selectedInd],
                height: 300,
              ),
            ],
          );
  }
}
