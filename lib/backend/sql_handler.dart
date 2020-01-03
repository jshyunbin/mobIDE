import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

enum Database { project, ssh, setting }

class Project {
  final int id;
  final String name;
  final String description;
  final String initDate;
  final String modDate;
  final String localDir;
  final String sshName;

  Project(
      {this.id,
      this.name,
      this.description,
      this.initDate,
      this.modDate,
      this.localDir,
      this.sshName});

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

class SSH {
  final int id;
  final String name;
  final String host;
  final String username;
  final String password;

  SSH({this.id, this.name, this.host, this.username, this.password});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ip': host,
      'username': username,
      'password': password,
    };
  }
}

class Setting {
  final int id;
  final String key;
  final String value;

  Setting({this.id, this.key, this.value});

  Map<String, dynamic> toMap() {
    return {'id': id, 'key': key, 'value': value};
  }
}

class DatabaseHandler {
  var _db;
  Database _type;

  DatabaseHandler(this._type) {
    init();
  }

  Future<void> init() async {
    switch (_type) {
      case Database.project:
        _db = openDatabase(join(await getDatabasesPath(), 'mobIDE_database.db'),
            onCreate: (db, version) {
              return db.execute('CREATE TABLE project('
                  'id INTEGER PRIMARY KEY UNIQUE NOT NULL AUTOINCREMENT, '
                  'name TEXT NOT NULL UNIQUE, '
                  'description TEXT, '
                  'initDate TEXT NOT NULL, '
                  'modDate TEXT NOT NULL,'
                  'localDir TEXT NOT NULL, '
                  'sshName TEXT'
                  ')');
            }, version: 1);
        break;
      case Database.ssh:
        _db = openDatabase(join(await getDatabasesPath(), 'mobIDE_database.db'),
            onCreate: (db, version) {
              return db.execute('CREATE TABLE ssh('
                  'id INTEGER PRIMARY KEY UNIQUE NOT NULL AUTOINCREMENT, '
                  'name TEXT NOT NULL UNIQUE, '
                  'ip TEXT NOT NULL, '
                  'username TEXT NOT NULL, '
                  'password TEXT NOT NULL'
                  ')');
            }, version: 1);
        break;
      case Database.setting:
        _db = openDatabase(join(await getDatabasesPath(), 'mobIDE_database.db'),
            onCreate: (db, version) {
              return db.execute('CREATE TABLE setting('
                  'id INTEGER PRIMARY KEY UNIQUE NOT NULL AUTOINCREMENT, '
                  'key TEXT NOT NULL UNIQUE, '
                  'value TEXT NOT NULL, '
                  ')');
            }, version: 1);
        break;
    }
  }

//  Future<void> insert(int dataType, data) async {
//    if (dataType == 1) {
//      assert(data is Project);
//
//      await Database db = _projectDatabase;
//
//    }
//  }
}

var project = DatabaseHandler(Database.project);
var ssh = DatabaseHandler(Database.ssh);
var setting = DatabaseHandler(Database.setting);
