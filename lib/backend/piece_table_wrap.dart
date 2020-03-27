import 'dart:math';

import 'package:mobide/backend/file_system.dart';

class PieceTableWrap {
  SSHFile _file;
  List<String> data;

  SSHFile get file => _file;

  int _length = 0;
  int _cursorX = 0;
  int _cursorY = 0;

  int get length => _length;

  int get cursorX => _cursorX;

  int get cursorY => _cursorY;

  PieceTableWrap(this._file);

  Future<void> load(Function callback) async {
    var s = await _file.read();
    data = s.replaceAll("\t", "    ").split("\n");
    _length = s.length;
    callback();
  }

  Future<void> save() async {
    await _file.write(data.join("\n"));
  }

  void write(int c) {
    if (c == '\n'.codeUnitAt(0)) {
      var t = data[_cursorX].substring(_cursorY);
      data[_cursorX] = data[_cursorX].substring(0, _cursorY);
      data.insert(++_cursorX, t);
      _cursorY = 0;
    } else {
      data[_cursorX] = data[_cursorX].substring(0, _cursorY) +
          String.fromCharCode(c) +
          data[_cursorX].substring(_cursorY);
      ++_cursorY;
    }
    ++_length;
  }

  void writeString(String s) {
    s.replaceAll("\t", "    ");
    for (var i in s.runes) {
      write(i);
    }
  }

  void backspace() {
    if (_cursorY == 0) {
      if (_cursorX != 0) {
        --_cursorX;
        _cursorY = data[_cursorX].length;
        data[_cursorX] += data[_cursorX + 1];
        data.removeAt(_cursorX + 1);
      }
    } else {
      data[_cursorX] = data[_cursorX].substring(0, _cursorY - 1) +
          data[_cursorX].substring(_cursorY);
      --_cursorY;
    }
    --_length;
  }

  void moveUp() {
    if (_cursorX != 0) _cursorX--;
    _cursorY = min(_cursorY, data[_cursorX].length);
  }

  void moveDown() {
    if (_cursorX != data.length) _cursorX++;
    _cursorY = min(_cursorY, data[_cursorX].length);
  }

  void moveLeft() {
    if (_cursorY != 0) _cursorY--;
  }

  void moveRight() {
    if (_cursorY != data[_cursorX].length) _cursorY++;
  }

  String currentLine() {
    return data[_cursorX];
  }

  String currentWord() {
    var s = currentLine().substring(0, _cursorY).split(" ").last;
    if (s.isNotEmpty) return s;
    if (_cursorX == 0 && _cursorY == 0) return "";
    return " ";
  }

  @override
  String toString() {
    return data.join("\n");
  }
}
