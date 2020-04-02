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
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';
import 'package:mobide/backend/file_system.dart';
import 'package:mobide/backend/piece_table_wrap.dart';

class CursorPainter extends CustomPainter {
  var x, y;
  var w, h;
  var editor;

  CursorPainter(
      double x, double y, double w, double h, _TextEditorState editor) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.editor = editor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.black;
    var center = Offset(this.x, this.y + this.h / 2);
    canvas.drawRect(
        Rect.fromCenter(center: center, width: w, height: h), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class TextEditor extends StatefulWidget {
  final PieceTableWrap table;

  TextEditor({@required this.table});

  TextEditor.fromFile({@required SSHFile file})
      : this(table: PieceTableWrap(file));

  @override
  _TextEditorState createState() => _TextEditorState(table);
}

class _TextEditorState extends State<TextEditor> {
  var _isLoading = true;
  var _isTyping = false;
  var startIndex = 0;
  FocusNode focusNode;
  PieceTableWrap table;
  var controller = TextEditingController(text: "");
  var startX, startY;

  _TextEditorState(PieceTableWrap table) {
    this.table = table;
  }

  @override
  void initState() {
    super.initState();
    this.focusNode = FocusNode();
    this.table.load(() {
      setState(() {
        this._isLoading = false;
      });
    });
  }

  Size getSize(String s) {
    var painter = TextPainter(
      text: TextSpan(
        text: s,
        style: TextStyle(
          fontFamily: 'Menlo',
          fontSize: 16,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return painter.size;
  }

  @override
  void dispose() {
    this.focusNode.dispose();
    super.dispose();
  }

  Widget _buildLoading() {
    return Container(
      color: Colors.lightBlue,
      child: Center(
        child: Loading(
          // TODO: change loading indicator
          indicator: BallScaleIndicator(),
          color: Colors.pink,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: min(this.table.data.length - startIndex, 40),
      itemBuilder: (BuildContext context, int index) {
        index += startIndex;
        var ss = "${index + 1}";
        while (ss.length < 3) ss = ' ' + ss;
        return Container(
          child: Text(
            " $ss " + this.table.data[index],
            style: TextStyle(
              fontFamily: 'Menlo',
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var s = this.table.currentLine();
    var ss = "${this.table.cursorX + 1}";
    while (ss.length < 3) ss = ' ' + ss;
    var cursor = getSize(" $ss " + s.substring(0, this.table.cursorY));
    var leftWidth = cursor.width -
        getSize(" $ss " + s.substring(0, max(this.table.cursorY - 1, 0))).width;
    var rightWidth =
        getSize(" $ss " + s.substring(0, min(this.table.cursorY + 1, s.length)))
                .width -
            cursor.width;
    return this._isLoading
        ? _buildLoading()
        : Container(
            margin: EdgeInsets.only(top: 10),
            child: Stack(
              children: <Widget>[
                _buildContent(),
                CustomPaint(
                  painter: CursorPainter(
                      cursor.width,
                      cursor.height * (this.table.cursorX - this.startIndex),
                      2,
                      cursor.height,
                      this),
                ),
                GestureDetector(
                  onTap: () {
                    if (this.focusNode.hasFocus) {
                      FocusScope.of(context).unfocus();
                      this._isTyping = false;
                    } else {
                      FocusScope.of(context).requestFocus(this.focusNode);
                      this._isTyping = true;
                    }
                  },
                  onPanDown: (details) {
                    startX = details.globalPosition.dx;
                    startY = details.globalPosition.dy;
                  },
                  onPanUpdate: (details) {
                    var dx = details.globalPosition.dx - startX;
                    var dy = details.globalPosition.dy - startY;

                    if (dy >= cursor.height) {
                      startY += cursor.height;
                      setState(() {
                        this.table.moveDown();
                        if (this.table.cursorX - this.startIndex >= 20) {
                          this.startIndex++;
                          startY -= cursor.height;
                        }
                        this.controller.text = this.table.currentWord();
                      });
                    } else if (dy <= -cursor.height) {
                      startY -= cursor.height;
                      setState(() {
                        this.table.moveUp();
                        if (this.table.cursorX - this.startIndex <= 0 &&
                            this.startIndex > 0) {
                          this.startIndex--;
                          startY += cursor.height;
                        }
                        this.controller.text = this.table.currentWord();
                      });
                    } else if (dx > 0) {
                      if (rightWidth > 0 && dx >= rightWidth) {
                        startX += rightWidth;
                        setState(() {
                          this.table.moveRight();
                          this.controller.text = this.table.currentWord();
                        });
                      }
                      if (rightWidth == 0) {
                        startX = details.globalPosition.dx;
                      }
                    } else if (dx < 0) {
                      if (leftWidth > 0 && dx <= -leftWidth) {
                        startX -= leftWidth;
                        setState(() {
                          this.table.moveLeft();
                          this.controller.text = this.table.currentWord();
                        });
                      }
                      if (leftWidth == 0) {
                        startX = details.globalPosition.dx;
                      }
                    }
                  },
                ),
                Opacity(
                  child: Container(
                    child: TextField(
                      focusNode: this.focusNode,
                      onChanged: (String text) {
                        print("${this.table.currentWord()} -> $text");
                        var s = this.table.currentWord();
                        if (text.length > s.length) {
                          setState(() {
                            this.table.write(text.runes.last);
                            if (this.table.cursorX - this.startIndex <= 0 &&
                                this.startIndex > 0) {
                              this.startIndex--;
                            }
                            if (this.table.cursorX - this.startIndex >= 20) {
                              this.startIndex++;
                            }
                            this.controller.text = this.table.currentWord();
                          });
                        } else if (text.length < s.length) {
                          setState(() {
                            this.table.backspace();
                            if (this.table.cursorX - this.startIndex <= 0 &&
                                this.startIndex > 0) {
                              this.startIndex--;
                            }
                            if (this.table.cursorX - this.startIndex >= 20) {
                              this.startIndex++;
                            }
                            this.controller.text = this.table.currentWord();
                          });
                        }
                      },
                      controller: this.controller,
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                    ),
                    height: 0,
                  ),
                  opacity: 0.0,
                ),
              ],
            ),
          );
  }
}
