import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return null;
  }
}
