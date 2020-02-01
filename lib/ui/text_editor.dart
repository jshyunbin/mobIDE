import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';
import 'package:mobide/backend/file_system.dart';
import 'package:mobide/backend/piece_table_wrap.dart';

class CursorPainter extends CustomPainter {
  var x, y;
  var editor;

  CursorPainter(double x, double y, _TextEditorState editor) {
    this.x = x;
    this.y = y;
    this.editor = editor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.black;
    var center = Offset(this.x, this.y);
    canvas.drawRect(
        Rect.fromCenter(center: center, width: 2, height: 16), paint);
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
  var x, y;
  FocusNode focusNode;
  PieceTableWrap table;

  _TextEditorState(PieceTableWrap table) {
    this.table = table;
  }

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    this.table.load(() {
      setState(() {
        _isLoading = false;
        x = 156.0;
        y = 10.0;
      });
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
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
    var s = this.table.toString().replaceAll("\t", "    ").split('\n');
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: s.length,
      itemBuilder: (BuildContext context, int index) {
        var ss = "${index + 1}";
        while (ss.length < 3) ss = ' ' + ss;
        return Container(
          child: Text(
            " $ss " + s[index],
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
    return _isLoading
        ? _buildLoading()
        : Stack(
            children: <Widget>[
              _buildContent(),
//              CustomPaint(
//                painter: CursorPainter(x, y, this),
//              ),
              GestureDetector(
                onTap: () {
                  if (focusNode.hasFocus) {
                    FocusScope.of(context).unfocus();
                  } else {
                    FocusScope.of(context).requestFocus(focusNode);
                  }
                  print("Tap");
                },
              ),
              Opacity(
                child: TextField(
                  focusNode: focusNode,
                  onChanged: (String text) {
                    print(text);
                  },
                ),
                opacity: 0.0,
              ),
            ],
          );
  }
}
