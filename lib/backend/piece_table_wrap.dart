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
import 'package:mobide/backend/file_system.dart';
import 'package:piece_table/piece_table.dart';

class PieceTableWrap {
  PieceTable _table;
  SSHFile _file;

  SSHFile get file => _file;

  int get length => _table.length;

  int get cursor => _table.cursor;

  PieceTableWrap(this._file);

  Future<void> load(Function callback) async {
    _table = PieceTable(await _file.read());
    callback();
  }

  Future<void> save() async {
    await _file.write(_table.toString());
  }

  void write(String s) {
    _table.write(s);
  }

  void backspace() {
    _table.backspace();
  }

  String around(int before, int after) {
    print(_table.toString());
    return _table.around(before, after);
  }

  void moveCursor(int d) {
    _table.moveCursor(d);
  }

  @override
  String toString() {
    return _table.toString();
  }
}
