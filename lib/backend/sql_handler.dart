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
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

enum DBType { project, ssh, setting }

abstract class DataType {
  final id;

  DataType(this.id);

  Map<String, dynamic> toMap();
}

class Project implements DataType {
  final int id;
  final String name;
  final String description;
  final String initDate;
  final String modDate;
  final String localDir;
  final String sshName;

  Project({this.id,
    @required this.name,
    @required this.description,
    @required this.initDate,
    @required this.modDate,
    @required this.localDir,
    @required this.sshName});

  Project.fromMap(Map<String, dynamic> map)
      : this(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      initDate: map['initDate'],
      modDate: map['modDate'],
      localDir: map['localDir'],
      sshName: map['sshName']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'initDate': initDate,
      'modDate': modDate,
      'localDir': localDir,
      'sshName': sshName,
    };
  }
}

class SSH implements DataType {
  final int id;
  final String name;
  final String host;
  final int port;
  final String username;
  final String password;

  SSH({this.id,
    @required this.name,
    @required this.host,
    @required this.port,
    @required this.username,
    @required this.password});

  SSH.fromMap(Map<String, dynamic> map)
      : this(
      id: map['id'],
      name: map['name'],
      host: map['host'],
      port: map['port'],
      username: map['username'],
      password: map['password']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'host': host,
      'port': port,
      'username': username,
      'password': password,
    };
  }
}

class Setting implements DataType {
  final int id;
  final String key;
  final String value;

  Setting({this.id, @required this.key, @required this.value});

  Setting.fromMap(Map<String, dynamic> map)
      : this(id: map['id'], key: map['key'], value: map['value']);

  Map<String, dynamic> toMap() {
    return {'id': id, 'key': key, 'value': value};
  }
}

class DatabaseHandler {
  Future<Database> _db;

  static String _typeToString(DBType t) {
    switch (t) {
      case DBType.project:
        return 'project';
      case DBType.ssh:
        return 'ssh';
      case DBType.setting:
        return 'setting';
    }
    return '';
  }

  DatabaseHandler() {
    init();
  }

  Future<void> init() async {
    _db = openDatabase(join(await getDatabasesPath(), 'mobIDE_database.db'),
        onCreate: (db, version) {
          db.execute(''
              'CREATE TABLE project('
              '  id INTEGER PRIMARY KEY UNIQUE NOT NULL AUTOINCREMENT, '
              '  name TEXT NOT NULL UNIQUE, '
              '  description TEXT, '
              '  initDate TEXT NOT NULL, '
              '  modDate TEXT NOT NULL,'
              '  localDir TEXT NOT NULL, '
              '  sshName TEXT'
              ')');
          db.execute(''
              'CREATE TABLE ssh('
              '  id INTEGER PRIMARY KEY UNIQUE NOT NULL AUTOINCREMENT, '
              '  name TEXT NOT NULL UNIQUE, '
              '  ip TEXT NOT NULL, '
              '  port INTEGER NOT NULL, '
              '  username TEXT NOT NULL, '
              '  password TEXT NOT NULL'
              ')');
          db.execute(''
              'CREATE TABLE setting('
              '  id INTEGER PRIMARY KEY UNIQUE NOT NULL AUTOINCREMENT, '
              '  key TEXT NOT NULL UNIQUE, '
              '  value TEXT NOT NULL'
              ')');
        }, version: 1);
  }

  /// returns the auto-incremented id
  Future<int> insert(DBType type, DataType data) async {
    final Database db = await _db;

    return db.insert(_typeToString(type), data.toMap(),
        conflictAlgorithm: ConflictAlgorithm.fail);
  }

  Future<List<DataType>> getData(DBType type) async {
    final Database db = await _db;

    final List<Map<String, dynamic>> maps = await db.query(_typeToString(type));

    switch (type) {
      case DBType.project:
        return List.generate(maps.length, (i) {
          return Project.fromMap(maps[i]);
        });
      case DBType.ssh:
        return List.generate(maps.length, (i) {
          return SSH.fromMap(maps[i]);
        });
      case DBType.setting:
        return List.generate(maps.length, (i) {
          return Setting.fromMap(maps[i]);
        });
      default:
        return null;
    }
  }

  Future<void> update(DBType type, DataType data) async {
    final Database db = await _db;

    await db.update(_typeToString(type), data.toMap(),
        where: 'id = ?', whereArgs: [data.id]);
  }

  Future<void> delete(DBType type, int id) async {
    final Database db = await _db;

    await db.delete(_typeToString(type), where: 'id = ?', whereArgs: [id]);
  }
}

final db = DatabaseHandler();
