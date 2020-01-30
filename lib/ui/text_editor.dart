import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';
import 'package:mobide/backend/file_system.dart';
import 'package:mobide/backend/piece_table_wrap.dart';

class TextEditor extends StatefulWidget {
  final PieceTableWrap table;

  TextEditor({@required this.table});

  TextEditor.fromFile({@required SSHFile file})
      : this(table: PieceTableWrap(file));

  @override
  _TextEditorState createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  var _isLoading = true;

  void initState() {
    super.initState();
    widget.table.load(() {
      setState(() {
        _isLoading = false;
      });
    });
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
    var s = widget.table.toString().split('\n');
    print(s.length);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: s.length,
      itemBuilder: (BuildContext context, int index) {
        var ss = "$index";
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
    return _isLoading ? _buildLoading() : _buildContent();
  }
}
