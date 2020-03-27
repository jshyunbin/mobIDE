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

import 'package:mobide/backend/file_system.dart';

class PieceTableWrap {
  SSHFile _file;
  List<String> data = [""];

  SSHFile get file => _file;

  int _length = 0;
  int _cursorX = 0;
  int _cursorY = 0;

  int get length => _length;

  int get cursorX => _cursorX;

  int get cursorY => min(_cursorY, data[_cursorX].length);

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
    _cursorY = cursorY;
    if (c == '\n'.codeUnitAt(0)) {
      var t = data[_cursorX].substring(cursorY);
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
    _cursorY = cursorY;
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
  }

  void moveDown() {
    if (_cursorX != data.length - 1) _cursorX++;
  }

  void moveLeft() {
    _cursorY = cursorY;
    if (_cursorY != 0) _cursorY--;
  }

  void moveRight() {
    _cursorY = cursorY;
    if (_cursorY != data[_cursorX].length) _cursorY++;
  }

  String currentLine() {
    return data[_cursorX];
  }

  String currentWord() {
    var s = currentLine().substring(0, cursorY).split(" ").last;
    if (s.isNotEmpty) return s;
    if (_cursorX == 0 && cursorY == 0) return "";
    return " ";
  }

  @override
  String toString() {
    return data.join("\n");
  }
}
