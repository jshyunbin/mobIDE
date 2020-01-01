import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Project {
  Project(
      {this.id,
      this.name,
      this.description,
      this.initDate,
      this.modiDate,
      this.localDir,
      this.sshName});

  final int id;
  final String name;
  final String description;
  final String initDate;
  final String modiDate;
  final String localDir;
  final String sshName;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'initDate': initDate,
      'modiDate': modiDate,
      'localDir': localDir,
      'sshName': sshName,
    };
  }
}

class SSH {
  SSH({this.id, this.name, this.ip, this.username, this.password});

  final int id;
  final String name;
  final String ip;
  final String username;
  final String password;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ip': ip,
      'username': username,
      'password': password,
    };
  }
}

class DatabaseHandler {
  DatabaseHandler() {
    init();
  }

  var _projectDatabase;
  var _sshDatabase;

  static const DATATYPE_PROJECT = 1;
  static const DATATYPE_SSH = 2;

  Future<void> init() async {
    _projectDatabase = openDatabase(
        join(await getDatabasesPath(), 'project.db'), onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE project(id INTEGER PRIMARY KEY UNIQUE NOT NULL '
          'AUTOINCREMENT, name TEXT NOT NULL UNIQUE, description TEXT, '
          'initDate TEXT NOT NULL, modiDate TEXT, NOT NULL'
          'localDir TEXT NOT NULL, sshName TEXT)');
    }, version: 1);
    _sshDatabase = openDatabase(join(await getDatabasesPath(), 'ssh.db'),
        onCreate: (db, version) {
      return db
          .execute('CREATE TABLE ssh(id INTEGER PRIMARY KEY UNIQUE NOT NULL '
              'AUTOINCREMENT, name TEXT NOT NULL UNIQUE, ip TEXT NOT NULL,'
              ' username TEXT NOT NULL, passwor TEXT NOT NULL)');
    }, version: 1);
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
