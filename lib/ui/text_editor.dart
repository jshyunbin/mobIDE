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
  var x, y;
  FocusNode focusNode;
  PieceTableWrap table;
  var controller = TextEditingController(text: "Hello");
  Size size;

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
        this.x = 4.0;
        this.y = 0.0;
      });
    });
    var painter = TextPainter(
      text: TextSpan(
        text: " ",
        style: TextStyle(
          fontFamily: 'Menlo',
          fontSize: 16,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    this.size = painter.size;
    print(this.size.width);
    print(this.size.height);
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
    return this._isLoading
        ? _buildLoading()
        : Container(
      margin: EdgeInsets.only(top: 10),
      child: Stack(
        children: <Widget>[
          _buildContent(),
          CustomPaint(
            painter: CursorPainter((this.x + 5) * this.size.width,
                this.y * this.size.height, 2, this.size.height, this),
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
          ),
          Opacity(
            child: Container(
              child: TextField(
                focusNode: this.focusNode,
                onChanged: (String text) {
                  this.controller.text = "Hello";
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
